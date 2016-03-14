;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;Backup configuration
(defvar --backup-directory (concat user-emacs-directory (convert-standard-filename "backups/")))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      vc-make-backup-files t            ; back up versioned files, as files are not commited on every save
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      )
;;Delete Old Back up files, greater than 2 weeks, 1 week = (week (* 60 60 24 7))
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7 2))
      (current (float-time (current-time))))
  (dolist (file (directory-files --backup-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))
