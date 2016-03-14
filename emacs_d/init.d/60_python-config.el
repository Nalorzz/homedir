;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;In Python: pip/py-pip install:elpy rope jedi
;;look at virtualenv

;;Load Python-Mode, watch this as there may be elpy/jedi issues with this
;; (if (locate-library "python-mode")
;;     (progn
;;       (autoload 'python-mode "python-mode" "Start python-mode" t)
;;       ;;(require 'python-mode)
;;     )
;;   )

;;Jedi Support
;; (if (locate-library "jedi")
;;     (progn
;;       (autoload 'jedi "jedi" "Start jedi python" t)
;;       ;;(require 'jedi) ;;
;;       (add-hook 'python-mode-hook 'jedi:setup)
;;       (setq jedi:setup-keys t)                      ; optional
;;       (setq jedi:complete-on-dot t)                 ; optional
;;     )
;;   )

;;Load Python-Mode ELPY
(if (locate-library "elpy")
    (progn
      (autoload 'elpy "elpy" "Start elpy python" t)
      ;;(require 'elpy nil t)
      ;; Enable elpy mode
      (elpy-enable)
      (setq elpy-interactive-python-command "python2.7")
      ;;(setq elpy-interactive-python-command 'python-python-command)
      (setq elpy-rpc-python-command "python2.7")
      ;;(setq elpy-rpc-python-command 'python-python-command)
      (elpy-clean-modeline) ;; Simplify modeline
      ;;(elpy-use-ipython) ;;Use if we have iPython
      (setq elpy-rpc-backend "jedi") ;; jedi as completion backend
      (when (executable-find "ipython")
        (elpy-use-ipython)) ;; To use ipython
      )
  )

;;WSGI files are just Python files in disguise, so tell them to use the Python environment
(add-to-list 'auto-mode-alist '("\\.wsgi$" . python-mode))

; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
