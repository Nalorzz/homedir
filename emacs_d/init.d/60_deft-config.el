;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(if (locate-library "deft")
    (progn
      (autoload 'deft "deft" "Start deft" t)
      (setq deft-directory "~/Notes/org"
            ;;deft-directory "~/Dropbox/Notes/"
            deft-extension "org"
            deft-text-mode 'org-mode
            ;;deft-text-mode 'markdown-mode
            ;;deft-use-filename-as-title t
            ;;(global-set-key (kbd "<f9>") 'deft)
            )
      )
  )
