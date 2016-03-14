;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(eval-after-load 'dired
  '(progn
     ;;Improved dired
     (if (locate-library "dired+")
         (progn
           (autoload 'dired+ "dired+" "Start dired+" t)
           ;;(require 'dired+) ;;Done to support color-moccur
           (setq dired-recursive-deletes 'top)
           (define-key dired-mode-map [mouse-2] 'dired-find-file)
           )
       )
     )
  )
