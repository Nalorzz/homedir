;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;Bring in ACE Jump Mode and Window
(if (locate-library "ace-jump-mode")
    (progn
      (autoload 'ace-jump-mode "ace-jump-mode" "Starting ace-jump-mode" t)
      ;;(require 'ace-jump-mode)
      (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
      ;; enable a more powerful jump back function from ace jump ;-*- mode: ${1:mode} -*-
      (autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
      (eval-after-load "ace-jump-mode"'
        (ace-jump-mode-enable-mark-sync))
      ;;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
      (define-key global-map (kbd "C-c M-SPC") 'ace-jump-mode-pop-mark)
      (if (locate-library "ace-window")
          (progn
            (autoload 'ace-window "ace-window" "Ace Window" t)
            ;;(global-set-key (kbd "M-p") 'ace-window)
            (global-set-key (kbd "C-c w") 'ace-window)
            ))
      )
  )
