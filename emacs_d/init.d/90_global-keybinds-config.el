;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global keybindings
;;

;; disable C-z on X11 sessions and windows
(when graphicalp
  (global-unset-key (kbd "C-z")))

;; C-pgup goes to the start, C-pgdw goes to the end
(global-set-key (kbd "<C-prior>")
  (lambda()(interactive)(goto-char(point-min))))
(global-set-key (kbd "<C-next>")
  (lambda()(interactive)(goto-char(point-max))))

;;Frame Switching
(global-set-key "\M-`" 'other-frame)
;;(global-set-key "\M-`" 'next-multiframe-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
