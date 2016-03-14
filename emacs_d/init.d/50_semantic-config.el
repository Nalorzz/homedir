;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

; Add CEDET to emacs
;;; EDE/Sementic customization
(global-ede-mode t)
(ede-enable-generic-projects)
(require 'semantic/sb)
(require 'semantic/ia)
(semantic-mode t)
;; Add to imenu the semantic hooks
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;Add in ImenuSupport
(defun try-to-add-imenu ()
  (condition-case nil (imenu-add-to-menubar "ImenuBar") (error nil)))
(add-hook 'font-lock-mode-hook 'try-to-add-imenu)

;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))
;;;;;;;;;;Temp Hack until I can get the checks to work, above check should work
;;;;;;;;;;Could add the actual global stuff to it.
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-exuberent-ctags-support))

(global-semantic-idle-scheduler-mode t) ; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-breadcrumbs-mode t) ;http://www.emacswiki.org/emacs/SemanticIdleBreadcrumbsMode


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; YASnipper and Auto-Complete
;; Might have to work these with the Semantic Code I'm running
;;
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(if (locate-library "yasnippet")
    (progn
      (require 'yasnippet)
      (yas-global-mode 1)
      (setq yas-indent-line 'auto) ;;Tell YAS to indent as the mode requires vales: fixed, auto
      (setq yas-also-auto-indent-first-line t) ;;Tell YAS to indent as the mode for the first line
      ))

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(if (locate-library "auto-complete-config")
    (progn
      (require 'auto-complete-config)
      (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
      (ac-config-default)
      ;;(setq ac-sources '(ac-source-semantic ac-source-yasnippet))
      (setq ac-sources '(ac-source-yasnippet))
      ;; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
      (defun my:ac-c-header-init ()
        (require 'auto-complete-c-headers)
        (add-to-list 'ac-sources 'ac-source-c-headers)
        ;;(add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
        )
      ;; now let's call this function from c/c++ hooks
      (add-hook 'c++-mode-hook 'my:ac-c-header-init)
      (add-hook 'c-mode-hook 'my:ac-c-header-init)

      ;; let's define a function which adds semantic as a suggestion backend to auto complete
      ;; and hook this function to c-mode-common-hook
      (defun my:add-semantic-to-autocomplete() 
        (add-to-list 'ac-sources 'ac-source-gtags)
        (add-to-list 'ac-sources 'ac-source-semantic)
        )
      (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

      ;; set the trigger key so that (insert )t can work together with yasnippet on tab key,
      ;; if the word exists in yasnippet, pressing tab will cause yasnippet to
      ;; activate, otherwise, auto-complete will
      (ac-set-trigger-key "<tab>")
      (ac-set-trigger-key "TAB")
      ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
