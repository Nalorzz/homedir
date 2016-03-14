;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-



;;ggtags.el
;;Compile and install Global with exuberant-ctags
;;pip install pygments
;; git clone https://github.com/yoshizow/global-pygments-plugin.git
;; sh reconf.sh
;; ./configure --prefix=<PREFIX> --with-exuberant-ctags=/usr/local/bin/ctags
;; make && make install
;; cp sample.globalrc $HOME/.globalrc

;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t))

;; (defvar  my-use-ggtags nil
;;    "Use the ggtags instead of gtags for GNU Global")
;; (setq my-use-ggtags t)

;; (if (eq (locate-library "ggtags") nil)
;;     (setq my-use-ggtags nil)
;;     )

;; (if (eq my-use-ggtags nil)
;;     (progn
;;       ;;GNU Globals With gtags
;;       (if (locate-library "gtags")
;;           (progn
;;             ;;GNU Globals Specific
;;             (autoload 'gtags-mode "gtags" "" t)

;;             (require 'gtags)

;;             (defun ww-next-gtag ()
;;               "Find next matching tag, for GTAGS."
;;               (interactive)
;;               (let ((latest-gtags-buffer
;;                      (car (delq nil  (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
;;                                              (buffer-list)) ))))
;;                 (cond (latest-gtags-buffer
;;                        (switch-to-buffer latest-gtags-buffer)
;;                        (forward-line)
;;                        (gtags-select-it nil))
;;                       ) ))

;;             ;;Single File Update Support
;;             (defun gtags-root-dir ()
;;               "Returns GTAGS root directory or nil if doesn't exist."
;;               (with-temp-buffer
;;                 (if (zerop (call-process "global" nil t nil "-pr"))
;;                     (buffer-substring (point-min) (1- (point-max)))
;;                   nil)))

;;             (defun gtags-update-single(filename)
;;               "Update Gtags database for changes in a single file"
;;               (interactive)
;;               (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

;;             (defun gtags-update-current-file()
;;               (interactive)
;;               (defvar filename)
;;               (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
;;               (gtags-update-single filename)
;;               (message "Gtags updated for %s" filename))

;;             (defun gtags-update-hook()
;;               "Update GTAGS file incrementally upon saving a file"
;;               (when gtags-mode
;;                 (when (gtags-root-dir)
;;                   (gtags-update-current-file))))

;;             (add-hook 'after-save-hook 'gtags-update-hook)
;;             ;;End Single File Update support
;;             ;;Multi File Update Support using some of the Single File routines
;;             (defun gtags-update ()
;;               "Make GTAGS incremental update"
;;               (call-process "global" nil nil nil "-u"))

;;             (defun gtags-update-all-hook ()
;;               (when (gtags-root-dir)
;;                 (gtags-update)))

;;             ;;(add-hook 'after-save-hook #'gtags-update-hook)
;;             ;;Multi File Update Support using some of the Single File routines



;;             (global-set-key "\M-;" 'ww-next-gtag) ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,
;;             (global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
;;             (global-set-key "\M-*" 'gtags-pop-stack) ;; M-* return to original position
;;             (global-set-key "\M-," 'gtags-find-rtag) ;; reverse tag
;;             (global-set-key [(control meta ?.)] 'gtags-find-rtag) ;; C-M-. find all references of tag
;;             (global-set-key [(control meta ?,)] 'gtags-find-symbol) ;; C-M-, find all usages of symbol.

;;             ;; (add-hook 'gtags-mode-hook
;;             ;;   (lambda()
;;             ;;     (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
;;             ;;     (local-set-key (kbd "M-,") 'gtags-find-rtag)))  ; reverse tag

;;             (add-hook 'c-mode-common-hook
;;                       (lambda ()
;;                         (require 'gtags)
;;                         (gtags-mode t)
;;                         ))

;;             (add-hook 'c-mode-common-hook
;;                       (lambda ()
;;                         (add-hook 'after-save-hook 'gtags-update-hook)
;;                         ))

;;             (add-hook 'gtags-select-mode-hook
;;                       '(lambda ()
;;                          (setq hl-line-face 'underline)
;;                          (hl-line-mode 1)
;;                          ))

;;             )
;;         )
;;       )
;;   (if (locate-library "ggtags")
;;       (progn
;;         (add-hook 'c-mode-common-hook
;;                   (lambda ()
;;                     (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;                       (ggtags-mode 1))))
;;         (global-set-key [(control meta ?,)] 'ggtags-find-reference) ;; C-M-, find all usages of symbol.
;;         )
;;     )
;;   )

(if (locate-library "ggtags")
    (progn
      (add-hook 'c-mode-common-hook
                (lambda ()
                  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                    (ggtags-mode 1))))
      (global-set-key [(control meta ?,)] 'ggtags-find-reference) ;; C-M-, find all usages of symbol.
      (ggtags-update-on-save t)
      )
  )
