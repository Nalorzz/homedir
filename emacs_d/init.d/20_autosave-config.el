;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;Auto Save configuration, auto save files in "~/.emacs.d/auto-save/"
(defvar --autosave-directory (concat user-emacs-directory (convert-standard-filename "auto-save/")))
(if (not (file-exists-p --autosave-directory))
    (make-directory --autosave-directory t))

(setq auto-save-file-name-transforms
      `((".*" ,--autosave-directory t)))
(setq auto-save-default t               ; auto-save every buffer that visits a file
      delete-auto-save-files t          ; delete auto-save files when saved
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )
