;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(defun system-specific-setup()
  ;;Windows Specific
  ;; Add local lisp folder to load-path
  (setq load-path (append load-path (list (concat user-emacs-directory
                                                  (convert-standard-filename "vendor/windows/"))
                                          )))

  ;;set up cygwin mount paths
  (require 'cygwin-mount)
  (cygwin-mount-activate)

;;;;
;;;; cygwin support
;;;;

;; Sets your shell to use cygwin's bash, if Emacs finds it's running
  ;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
  ;; not already in your Windows Path (it generally should not be).
  ;;
  (let* ((cygwin-root "c:/cygwin64/")
         (cygwin-bin (concat cygwin-root "/bin"))
         (cygwin-usrlocal-bin (concat cygwin-root "/usr/local/bin")))
    (when (and (eq 'windows-nt system-type)
               (file-readable-p cygwin-root))

      (setq exec-path (cons cygwin-bin exec-path))
      (setq exec-path (cons cygwin-usrlocal-bin exec-path))
      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
      (setenv "PATH" (concat cygwin-usrlocal-bin ";" (getenv "PATH")))

      ;; By default use the Windows HOME.
      ;; Otherwise, uncomment below to set a HOME
      ;;      (setenv "HOME" (concat cygwin-root "/home/eric"))

      ;; NT-emacs assumes a Windows shell. Change to baash.
      (setq shell-file-name "bash")
      (setenv "SHELL" shell-file-name)
      (setq explicit-shell-file-name shell-file-name)
      ))

  ;;Sets up a lot of cygwin stuff. Currently though shell is handled better above.
  (require 'setup-cygwin)

  ;; This removes unsightly ^M characters that would otherwise
  ;; appear in the output of java applications.
  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)


  )

(defun cygwin-specific-setup-old()
  ;;Windows Specific
  ;; Add local lisp folder to load-path
  (setq load-path (append load-path (list "~/elisp/windows" )))

  ;;set up cygwin mount paths
  (require 'cygwin-mount)
  (cygwin-mount-activate)

;;;;
;;;; cygwin support
;;;;
  ;; Sets your shell to use cygwin's bash, if Emacs finds it's running
  ;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
  ;; not already in your Windows Path (it generally should not be).
  ;;
  (let* ((cygwin-root "c:/cygwin64/")
         (cygwin-bin (concat cygwin-root "/bin"))
         (cygwin-usrlocal-bin (concat cygwin-root "/usr/local/bin")))
    (when (and (eq 'windows-nt system-type)
               (file-readable-p cygwin-root))

      (setq exec-path (cons cygwin-bin exec-path))
      (setq exec-path (cons cygwin-usrlocal-bin exec-path))
      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
      (setenv "PATH" (concat cygwin-usrlocal-bin ";" (getenv "PATH")))

      ;; By default use the Windows HOME.
      ;; Otherwise, uncomment below to set a HOME
      ;;      (setenv "HOME" (concat cygwin-root "/home/eric"))

      ;; NT-emacs assumes a Windows shell. Change to baash.
      (setq shell-file-name "bash")
      (setenv "SHELL" shell-file-name)
      (setq explicit-shell-file-name shell-file-name)

      ;; This removes unsightly ^M characters that would otherwise
      ;; appear in the output of java applications.
      (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))

  (require 'setup-cygwin)

  ;; Prevent issues with the Windows null device (NUL)
  ;; when using cygwin find with rgrep.
  (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
    "Use cygwin's /dev/null as the null-device."
    (let ((null-device "/dev/null"))
      ad-do-it))
  (ad-activate 'grep-compute-defaults)

  ;;; Windows only configuration
  ;; http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
  ;; make PC keyboard's Win key or other to type Super or Hyper, for emacs running on Windows.
  (setq w32-pass-lwindow-to-system nil
	w32-pass-rwindow-to-system nil
	w32-pass-apps-to-system nil
	;; Left Windows key
	w32-lwindow-modifier 'super
	;; Right Windows key
	w32-rwindow-modifier 'super
	;; Menu key
	w32-apps-modifier 'hyper)


  )
