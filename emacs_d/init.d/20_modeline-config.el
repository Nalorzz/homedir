;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the modeline
;; 
(line-number-mode t)                     ;; show line numbers
(column-number-mode t)                   ;; show column numbers
(size-indication-mode t)                 ;; show file size (emacs 22+)
(display-time-mode t)                    ;; show the system time


(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
  (progn 
    (setq sml-modeline-borders '("[" . "]"))
    (sml-modeline-mode t)                   ;; show buffer pos in the mode line
    (scroll-bar-mode -1)                    ;; turn off the scrollbar
    )                   
  (scroll-bar-mode t)                       ;; otherwise, show a scrollbar...
  (set-scroll-bar-mode 'right))             ;; ... on the right, use 'left for left
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
