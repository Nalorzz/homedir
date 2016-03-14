;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;; Setup for Compilation Mode

;;; Compilation Mode Setups ==========================================

(load-library "compile")

;;; For some reason, the gnu regex is capturing leading white space.
(setq compilation-error-regexp-alist
      (remq 'gnu compilation-error-regexp-alist))


(setq compilation-ask-about-save nil  ; Just save before compiling
      compilation-always-kill t       ; Just kill old compile processes before starting the new one
      ;;compilation-scroll-output t  ;; scroll the `*compilation*' buffer window to follow output as it appears
      compilation-scroll-output 'first-error ; Automatically scroll to first error
      )


;; Ruby test unit patterns.
(add-to-list 'compilation-error-regexp-alist
             '("\\([^ \t:\\[]+\\):\\([0-9]+\\):in" 1 2))

(add-to-list 'compilation-error-regexp-alist
             '("test[a-zA-Z0-9_]*([A-Z][a-zA-Z0-9_]*) \\[\\(.*\\):\\([0-9]+\\)\\]:" 1 2))


;; FIC pattern
(add-to-list 'compilation-error-regexp-alist
             '("^\\([^ \t:\\[]+\\):\\([0-9]+\\):" 1 2))

;; Turn off trailing space notification

(add-hook 'compilation-mode-hook '(lambda () (setq show-trailing-whitespace nil)))


;; Compilation from Emacs
(defun colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

;; (defun colorize-compilation-buffer-old ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))

;; Adding color to the `*compilation*' buffer window
(require 'ansi-color)
(add-hook 'compilation-filter-hook #'colorize-compilation-buffer)

;;; Use the following hook to remove colorization from the compile
;;; buffer for tests. This is occassionally needed when projecting on
;;; a low contrast screen (red test failures don't show up so well).
; (add-hook 'compilation-filter-hook 'unansi)

;;Bring in cmake compile mode
;;Not sure if this is needed so commented out.
;; (if (locate-library "cmake-project")
;;     (progn
;;       ((autoload 'cmake-project-mode "cmake-project" "Start cmake-project-mode" t)
;;        ;;(require 'cmake-project)
;;        ;;Autoload cmake mode if there is a CMakeList.txt
;;        (defun maybe-cmake-project-hook ()
;;          (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))
;;        (add-hook 'c-mode-hook 'maybe-cmake-project-hook)
;;        (add-hook 'c++-mode-hook 'maybe-cmake-project-hook)
;;       )
;;   )
