;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;Add in ibuffer
(when (fboundp 'ibuffer)
  (autoload 'ibuffer "ibuffer" "List buffers." t)
  (eval-after-load 'ibuffer
    '(progn
       ;; Use human readable Size column instead of original one
       (define-ibuffer-column size-h
         (:name "Size" :inline t)
         (cond
          ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
          ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
          (t (format "%8d" (buffer-size)))))
       ;; Explicitly require ibuffer-vc to get its column definitions, which
       ;; can't be autoloaded
       (require 'ibuffer-vc)

       (setq ibuffer-expert t
             ibuffer-show-empty-filter-groups nil
             ibuffer-display-summary nil)

       (setq ibuffer-saved-filter-groups
             (quote (("default"
                      ("C/C++ Code" (or (mode . c-mode)
                                        (mode . c++-mode)
                                        (mode . csharp-mode)
                                        (mode . objc-mode)
                                        ))
                      ("Python Code" (mode . python-mode))
                      ("Java Code" (mode . java-mode))
                      ("Lisp Code" (or (mode . emacs-lisp-mode)
                                       (mode . lisp-mode)
                                       ))
                      ("code" (or (mode . emacs-lisp-mode)
                                  (mode . cperl-mode)
                                  (mode . idl-mode)
                                  (mode . web-mode)
                                  (mode . lisp-mode)
                                  (mode . js2-mode)
                                  (mode . lua-mode)
                                  (mode . ruby-mode)
                                  (mode . scss-mode)
                                  (mode . css-mode)
                                  (mode . sql-mode)
                                  (mode . coffee-mode)
                                  (mode . php-mode)
                                  (mode . sh-mode)
                                  (mode . json-mode)
                                  (mode . scala-mode)
                                  (mode . go-mode)
                                  (mode . erlang-mode)
                                  ))
                      ("makefile" (or (mode . cmake-mode)
                                      (mode . makefile-mode)
                                   ))
                      ("dired" (or (mode . dired-mode)
                                   (mode . sr-mode)
                                   ))
                      ("erc" (mode . erc-mode))
                      ("planner" (or
                                  (name . "^\\*Calendar\\*$")
                                  (name . "^diary$")
                                  (mode . muse-mode)
                                  (mode . org-mode)
                                  (mode . org-agenda-mode)
                                  ))
                      ("emacs" (or
                                (name . "^\\*scratch\\*$")
                                (name . "^\\*Messages\\*$")))
                      ("gnus" (or
                               (mode . message-mode)
                               (mode . bbdb-mode)
                               (mode . mail-mode)
                               (mode . gnus-group-mode)
                               (mode . gnus-summary-mode)
                               (mode . gnus-article-mode)
                               (name . "^\\.bbdb$")
                               (name . "^\\.newsrc-dribble")))))))
       (add-hook 'ibuffer-mode-hook (lambda ()
                                      (ibuffer-vc-set-filter-groups-by-vc-root)
                                      (unless (eq ibuffer-sorting-mode 'filename/process)
                                        (ibuffer-do-sort-by-filename/process))
                                      (ibuffer-switch-to-saved-filter-groups "default")
                                      ))
       ;; (defun ibuffer-previous-line ()
       ;;   (interactive) (previous-line)
       ;;   (if (<= (line-number-at-pos) 2)
       ;;       (goto-line (- (count-lines (point-min) (point-max)) 2))))
       ;; (defun ibuffer-next-line ()
       ;;   (interactive) (next-line)
       ;;   (if (>= (line-number-at-pos) (- (count-lines (point-min) (point-max)) 1))
       ;;       (goto-line 3)))
       ;;;;;;;;Attempt to fix wrap
       (defun ibuffer-previous-line ()
         (interactive) (previous-line)
         (if (<= (line-number-at-pos) 2)
             (goto-line  (count-lines (point-min) (point-max)))
           ))
       (defun ibuffer-next-line ()
         (interactive) (next-line)
         (if (> (line-number-at-pos) 
                 (count-lines (point-min) (point-max)) 
                 )
             (goto-line 3)))

       (define-key ibuffer-mode-map (kbd "<up>") 'ibuffer-previous-line)
       (define-key ibuffer-mode-map (kbd "<down>") 'ibuffer-next-line)
       (define-key ibuffer-mode-map (kbd "C-p") 'ibuffer-previous-line)
       (define-key ibuffer-mode-map (kbd "C-n") 'ibuffer-next-line)
       ))


  ;; Modify the default ibuffer-formats
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 30 30 :left :elide) ; Originally 18
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                (vc-status 16 16 :left)
                " "
                filename-and-process)))

  (setq ibuffer-filter-group-name-face 'font-lock-doc-face)

  (global-set-key (kbd "C-x C-b") 'ibuffer)

  )
