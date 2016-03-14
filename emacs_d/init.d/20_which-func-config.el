;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(require 'which-func)
(add-to-list 'which-func-modes 'emacs-lisp-mode)
(add-to-list 'which-func-modes 'org-mode)
(setq which-func-unknown "n/a")
;; Show the current function name in the header line
(which-function-mode) ;;Global seeing of which
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
            ;; We remove Which Function Mode from the mode line, because it's mostly
            ;; invisible here anyway.
            (assq-delete-all 'which-func-mode mode-line-misc-info))


