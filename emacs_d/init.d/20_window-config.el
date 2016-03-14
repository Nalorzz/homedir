;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;----------------------------------------------------------------------------
;; Navigate window layouts with "C-c <left>" and "C-c <right>"
;;----------------------------------------------------------------------------
;; Undo/redo window layouts with "C-c <left>" and "C-c <right>"
(when (fboundp 'winner-mode) 
  (winner-mode 1)
  ;; copied from http://puntoblogspot.blogspot.com/2011/05/undo-layouts-in-emacs.html
  (global-set-key (kbd "C-x 4 u") 'winner-undo)
  (global-set-key (kbd "C-x 4 r") 'winner-redo)
  )

;;----------------------------------------------------------------------------
;; When splitting window, show (other-buffer) in the new window
;;----------------------------------------------------------------------------
(defun split-window-func-with-other-buffer (split-function)
  (lexical-let ((s-f split-function))
    (lambda ()
      (interactive)
      (funcall s-f)
      (set-window-buffer (next-window) (other-buffer)))))

(global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))


;;----------------------------------------------------------------------------
;; Rearrange split windows
;;----------------------------------------------------------------------------
(defun split-window-horizontally-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-horizontally))))

(defun split-window-vertically-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-vertically))))

(global-set-key "\C-x|" 'split-window-horizontally-instead)
(global-set-key "\C-x_" 'split-window-vertically-instead)

;;Add in better window and frame moving useing arrow keys and Meta
(if (locate-library "framemove") ;;framemove
    (progn
      (require 'framemove)
      ;;(framemove-default-keybindings) ;; default prefix is Meta
      (when (fboundp 'windmove-default-keybindings)
        (windmove-default-keybindings 'meta)) ;; Allows movement among windows with meta arrow keys
      (setq framemove-hook-into-windmove t)
      )
  (progn 
    (when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings 'meta)) ;; Allows movement among windows with meta arrow keys
    )
)
