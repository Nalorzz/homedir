;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; some handy packages
;;
;; uniquify: unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; hl-line: highlight the current line
;;(when (fboundp 'global-hl-line-mode)
;;  (global-hl-line-mode t)) ;; turn it on for all modes by default


;; Load svn mode
(if (locate-library "psvn")
    ;;(require 'psvn)
    (autoload 'psvn "psvn" "start psvn" t)
)

;;Advance bookmarks
(if (locate-library "bookmark+")
    (autoload 'bookmark+ "bookmark+" "start bookmark+" t))
;;(require 'bookmark+)

;;Improved grep
(if (locate-library "grep+")
    (autoload 'grep+ "grep+" "Start grep+" t))
;;(require 'grep+)


;;Bring in cmake mode for editing cmake files
(if (locate-library "cmake-mode")
    (progn
      (autoload 'cmake-mode "cmake-mode" "Start cmake-mode" t)
      ;;(require 'cmake-mode)
      (setq auto-mode-alist (append '(("CMakeLists\\.txt\\'" . cmake-mode))
                                    '(("\\.cmake\\'" . cmake-mode))
                                    auto-mode-alist))
      )
  )

;;Bring in protobuf mode with cc mode
(if (locate-library "protobuf-mode")
    (autoload 'protobuf-mode "protobuf-mode" "Start protobuf-mode" t))
;;(require 'protobuf-mode)

;;Bring in color multi occur
(if (locate-library "color-moccur")
    (progn
      ;;(autoload 'color-moccur "color-moccur" "Start color-moccur" t)
      (require 'color-moccur)
      (define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
      (define-key dired-mode-map "O" 'dired-do-moccur)
      (eval-after-load 'isearch-mode
        '(progn
           (define-key isearch-mode-map (kbd "C-o") 'isearch-moccur)
           (define-key isearch-mode-map (kbd "C-O") 'isearch-moccur-all)
           ;;(define-key isearch-mode-map (kbd "M-o") 'isearch-moccur)
           ;;(define-key isearch-mode-map (kbd "M-O") 'isearch-moccur-all)
           ))
      (global-set-key "\C-x\C-o" 'occur-by-moccur)
      (setq *moccur-buffer-name-exclusion-list*
            '(".+TAGS.+" "*Completions*" "*Messages*" "*Compile*"
              "*scratch*" "*occur*" "*CEDET*"))
      )
  )

;;Add in Rainbow Delimiters ( http://www.emacswiki.org/emacs/RainbowDelimiters )
;;Subtle colors parens and other delimiters, rather nice
(if (locate-library "rainbow-delimiters")
    (progn
      (autoload 'rainbow-delimiters "rainbow-delimiters" "Start rainbow-delimiters" t)
      ;;(require 'rainbow-delimiters)
      ;;(add-hook `c-mode-common-hook `rainbow-delimiters-mode)
      (add-hook 'prog-mode-hook 'rainbow-delimiters-mode) ;;Enable in all programming-related modes (Emacs 24+)
      ;;(global-rainbow-delimiters-mode) ;;Emacs Wide
      ))

;;Add in Rainbow Raindbow Identifier ( https://www.github.com/Fanael/rainbow-identifiers )
;;Color codes all the Identifiers in a file
;;Need to manually play with it to see if I like it, this code works though
;; (if (locate-library "rainbow-identifiers")
;;     (progn
;;       (autoload 'rainbow-identifiers "rainbow-identifiers" "Start rainbow-identifiers" t)
;;       ;;(add-hook `c-mode-common-hook `rainbow-identifiers-mode)
;;       (add-hook 'prog-mode-hook 'rainbow-identifiers-mode) ;;Enable in all programming-related modes (Emacs 24+)
;;       ))

;; Load vlf mode, to handle very large files
(if (locate-library "vlf")
    (progn
      (require 'vlf-integrate)
      (autoload 'vlf "vlf" "start vlf" t)
    )
)

;;Configure Visual Line Mode
(when (fboundp 'visual-line-mode)
  ;;Default visual line mode on generic text
  ;;(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'text-mode-hook (lambda ()
                              (visual-line-mode 1)))
  ;;Wrap the text when in org mode
  (add-hook 'org-mode-hook (lambda ()
                             (visual-line-mode 1)))
  ;;Wrap the text when in org indent mode
  (add-hook 'org-indent-mode-hook (lambda ()
                                    (visual-line-mode 1)))
  ;;(add-hook 'org-indent-mode-hook 'visual-line-mode)
  
  ;;Wrap the test when in LaTeX
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (visual-line-mode 1)))
  ;;Use the Fringe to mark that the line has been wrapped.
  (setq-default visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
  
  )


;;Bring in adaptive wrap for certain editing modes
(if (locate-library "adaptive-wrap")
    (progn
      ;;(autoload 'adaptive-wrap "adaptive-wrap" "Start adaptive-wrap" t)
      (require 'adaptive-wrap)
      
      (add-hook 'visual-line-mode-hook
                (lambda ()
                  (adaptive-wrap-prefix-mode 1)))
      )
  )

;; Working with adaptive-wrap, may need tweaking
;; (when (fboundp 'adaptive-wrap-prefix-mode)
;;   (defun my-activate-adaptive-wrap-prefix-mode ()
;;     "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
;;     (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
;;   (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode)
;;   )


;;PUML Mode (PlantUML Mode)
(if (locate-library "puml-mode")
    (progn
      (autoload 'puml-mode "puml-mode" "start puml-mode" t)
      (setq puml-plantuml-jar-path
            (expand-file-name "~/plantuml/plantuml.8030.jar"))
      ;; Enable puml-mode for PlantUML files
      (add-to-list 'auto-mode-alist
             '("\\.puml\\'" . puml-mode)
             '("\\.plantuml\\'" . puml-mode))
    )
)

;; Set up compile-dwim to use .dir-local for compile informaiton
(if (locate-library "compile-dwim")
    (progn
      (require 'compile-dwim)
      ;;(load-library "compile-dwim")
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; some misc other packages
;;


;;Add in diff-hl
;;It will add in colors to the "fringe" to show differences
(when (fboundp 'global-diff-hl-mode)
  ;;(global-diff-hl-mode t) ;;Add into all modes
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  ;;Fix for svn-status
  (defadvice svn-status-update-modeline (after svn-update-diff-hl activate)
    (diff-hl-update))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
