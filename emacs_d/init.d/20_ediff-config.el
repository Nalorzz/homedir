;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(require 'ediff)
; Make ediff not use that annoying seperate frame:
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
; and make it put the buffers side-by-side:
(setq ediff-split-window-function 'split-window-horizontally)
;; Load after ediff-util.
(defun ediff-toggle-whitespace-sensitivity ()
  "Toggle whitespace sensitivity for the current EDiff run.
This does not affect the global EDiff settings.  The function
automatically updates the diff to reflect the change."
  (interactive)
  (let ((post-update-message
         (if (string-match " ?-w$" ediff-actual-diff-options)
             (progn
               (setq ediff-actual-diff-options
                     (concat ediff-diff-options " " ediff-ignore-case-option)
                     ediff-actual-diff3-options
                     (concat ediff-diff3-options " " ediff-ignore-case-option3))
               "Whitespace sensitivity on")
           (setq ediff-actual-diff-options
                 (concat ediff-diff-options " " ediff-ignore-case-option " -w")
                 ediff-actual-diff3-options
                 (concat ediff-diff3-options " " ediff-ignore-case-option3 " -w"))
           "Whitespace sensitivity off")))
    (ediff-update-diffs)
    (message post-update-message)))
  (add-hook 'ediff-keymap-setup-hook
            #'(lambda () (define-key ediff-mode-map [?W] 'ediff-toggle-whitespace-sensitivity)))
; Put windows back correctly after it
(when (fboundp 'winner-mode)
  (add-hook 'ediff-after-quit-hook-internal 'winner-undo)
)
