;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; general settings
;;

;;Stop the start up screens
(setq inhibit-startup-screen t)
;; Turn off the bell
(setq visible-bell t)

(if (fboundp 'menu-bar-mode) (menu-bar-mode t))  ;; show the menu.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ;; turn-off toolbar

(mouse-wheel-mode t)                     ;; Make the mouse wheel work:
(mouse-avoidance-mode 'animate)          ;; Drive out the mouse when it's too near to the cursor.
;;(mouse-avoidance-mode 'jump)             ;; mouse ptr when cursor is too close
(setq mouse-wheel-progressive-speed nil) ;; don't let scrolling ramp up it unless the file is HUGE


(setq search-highlight t                 ;; Highlight during searching
  query-replace-highlight t)             ;; Highlight during search and replacing
(fset 'yes-or-no-p 'y-or-n-p)            ;; enable y/n answers to yes/no 

(setq kill-whole-line t) ;;If at beginning of a line, don't make me C-k twice.


(when unix-x-p
  (setq x-select-enable-clipboard t        ;; copy-paste should work ...
        interprogram-paste-function        ;; ...with...
        'x-cut-buffer-or-selection-value)  ;; ...other X clients
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
