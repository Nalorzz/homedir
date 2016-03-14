;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the minibuffer
;;
(setq
  enable-recursive-minibuffers nil       ;;  allow mb cmds in the mb
  max-mini-window-height .25             ;;  max 2 lines
  minibuffer-scroll-window nil
  resize-mini-windows nil)

(icomplete-mode t)                       ;; completion in minibuffer
(setq 
  icomplete-prospects-height 1           ;; don't spam my minibuffer
  icomplete-compute-delay 0)             ;; don't wait
(eval-after-load "icomplete" 
  '(progn (require 'icomplete+)))        ;; Enable icomplete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
