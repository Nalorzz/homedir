;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;Add in Org Mode
(require 'org-install)
(if (locate-library "org")
    (progn
      (autoload 'org "org" "Start org" t)
      ;;(require 'org)
      ;; flyspell mode for spell checking everywhere
      (add-hook 'org-mode-hook 'turn-on-flyspell 'append)
      ;;Wrap the text when in org mode
      ;;(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
      (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
      (global-set-key "\C-cl" 'org-store-link)
      (global-set-key "\C-cc" 'org-capture)
      (global-set-key "\C-ca" 'org-agenda)
      (global-set-key "\C-cb" 'org-iswitchb)

      ;;PlantUML in Org Mode
      (setq org-plantuml-jar-path
            (expand-file-name "~/plantuml/plantuml.jar" ))
      )
  )
