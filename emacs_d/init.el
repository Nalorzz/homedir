;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; systems
;;
(defconst win32p
    (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst cygwinp
    (eq system-type 'cygwin)
  "Are we running on a WinTel cygwin system?")

(defconst osxp
    (eq system-type 'darwin)
  "Are we running on a OS X system?")

(defconst linuxp
    (or (eq system-type 'gnu/linux)
        (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")

(defconst unixp
  (or linuxp
      (eq system-type 'usg-unix-v)
      (eq system-type 'berkeley-unix))
  "Are we running unix")

(defconst linux-x-p
  (and window-system linuxp)
  "Are we running under X on a GNU/Linux system?")

(defconst unix-x-p
  (and window-system unixp)
  "Are we running under X on a Unix system?")

(defconst graphicalp
  (not (eq window-system 'nil))
  "Are we running window system?")

(defconst aquamacs
  (boundp 'aquamacs-version)
  "Are we running Aquamacs on OS X?")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;Set Some limits
(setq max-specpdl-size 32000)
(setq max-lisp-eval-depth 32000)
(setq message-log-max 3000)
(setq history-length 100)
;;Adjust GC threshold to 50 megabytes. This dramatically improves startup time and helps with the overall speed of Emacs.
(setq gc-cons-threshold (* 50 1024 1024))
;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)
;; Always load newest byte code
(setq load-prefer-newer t)
;;Delay some frame/font modifications to speed up start up
;;;TODO, see if I really need this
(modify-frame-parameters nil '((wait-for-wm . nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set System Path information here
;;
;; Ensure that PATH is taken from shell
;; Necessary on some environments without virtualenv
;; Taken from: http://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell."
  (interactive)
  (let ((path-from-shell (get-shell-output "$SHELL --login -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


(when osxp
  ;set PATH, because we don't load .bashrc 
  (setenv "PATH" (concat "$HOME/bin:"
                         "/opt/local/sbin:" 
                         "/opt/local/bin:" 
                         "/bin:" 
                         "/usr/bin:" 
                         "/sbin:" 
                         "/usr/sbin:" 
                         "/usr/local/bin:" 
                         "/usr/local/sbin"))

  (setq python-version-checked t) 
  (setq python-python-command "python2.7" )
  (setq python-shell-interpreter "python2.7")

  ;;Set PYTHONPATH, because we don't load .bashrc 
  ;;(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages:") 
  ;;
  ;; Use python3 from homebrew.
  ;;(setq python-shell-interpreter "/usr/local/bin/python3")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the load path  
;;
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
    "Directory beneath which additional per-user Emacs-specific files are placed.
  Various programs in Emacs store information in this directory.
  Note that this should end with a directory separator.
  See also `locate-user-emacs-file'."))
;; Add local lisp folder to load-path
(setq load-path (append load-path (list (concat user-emacs-directory
                                                (convert-standard-filename "init.d/"))
                                        (concat user-emacs-directory
                                                (convert-standard-filename "init_os.d/"))
                                        (concat user-emacs-directory
                                                (convert-standard-filename "vendor/"))
                                        )))
                                        
;;; Configure load-path (load-path should only be defined in init.el)
;;
;; http://emacswiki.org/emacs/LoadPath ; Recursive for elpa directory
;; This is NECESSARY if init-loader.el is required before package.el package-initialize.
(let ((default-directory "~/.emacs.d/elpa/"))
       (normal-top-level-add-subdirs-to-load-path))
;;
;; el-get.el package system 2013-02-26 (additional configuration further below)
;; https://github.com/dimitri/el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")                                       

;;Add Package repositories, start packages for config, do not reload them after init
;; Replaced with 10_package-config.el, but there is a race condition with el-get.
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("org" . "http://orgmode.org/elpa/")
;;                          ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
;;                          ("melpa" . "http://melpa.milkbox.net/packages/") ;;Less stable packages
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ))
;; (package-initialize)
;; (setq package-enable-at-startup nil)


;; el-get
;; Currently have to preload the el-get directory, as the bootstrap does not work.
;; (add-to-list 'load-path (concat user-emacs-directory
;;                                          (convert-standard-filename "el-get/el-get")))
;; (setq-default el-get-dir (concat user-emacs-directory
;;                                          (convert-standard-filename "el-get/"))
;;               el-get-emacswiki-base-url "http://raw.github.com/emacsmirror/emacswiki.org/master/")
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))
;; (add-to-list 'el-get-recipe-path (concat user-emacs-directory
;;                                          (convert-standard-filename "el-get-user/recipes")))
;; (el-get 'sync)

;; el-get
;; Using Melpa to bootstrap
(add-to-list 'load-path (concat user-emacs-directory
				(convert-standard-filename "el-get/el-get")))
(setq-default el-get-dir (concat user-emacs-directory
				 (convert-standard-filename "el-get/")))

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory
					 (convert-standard-filename "el-get-user/recipes")))

(el-get 'sync)


;;Get the customizations into their own file
(setq custom-file (concat user-emacs-directory 
                          (convert-standard-filename "custom.el")))
(load custom-file 'noerror)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Load system-specific library and setup system-specific things that 
; must be setup before main setup 
(cond ((eq system-type 'windows-nt) (load-library "ntemacs-cygwin_config"))
      ((eq system-type 'gnu/linux) (load-library "linux_config"))
      ((eq system-type 'berkeley-unix) (load-library "linux_config"))
      ((eq system-type 'darwin) (load-library "cocoa-emacs-config"))
      (t (load-library "default"))
      )
(system-specific-setup)



;;; init-loader.el
;; https://github.com/emacs-jp/init-loader
;; http://d.hatena.ne.jp/hiro_nemu/20140118/1390058851
;; http://qiita.com/catatsuy/items/5f1cd86e2522fd3384a0
;; http://shibayu36.hatenablog.com/entry/20101229/1293624201
;;
;; This configuration is highly dependent on init-loader.el!
;;
;; Load init-loader.el
;;(el-get-bundle emacs-jp/init-loader)
(el-get 'sync 'init-loader)
(if (require 'init-loader nil 'noerror) ;; use init-loader
    (progn 
      ;; load
      (setq-default init-loader-show-log-after-init nil
                    init-loader-byte-compile t)
      (init-loader-load (concat user-emacs-directory
                                (convert-standard-filename "init.d/")))
      ;; load personal setting
      ;;(and (file-exists-p "~/.emacs.d/personal") (init-loader-load "~/.emacs.d/personal"))

      ;; hide compilation results
      (let ((win (get-buffer-window "*Compile-Log*")))
        (when win (delete-window win)))
      )
  (progn
    ;;Load the packages, and hope that it will kick things off
    (load-library "10_packages-config")
    )
  )
;;
;; Note that not all files in the directory are loaded.  Each file is
;; examined that if it is a .el or .elc file and, it has a valid name
;; specified by `init-loader-default-regexp' or it is a platform
;; specific configuration file.
;;
;; By default, valid names of configuration files start with two
;; digits.  For example, the following file names are all valid:
;;     00_util.el
;;     01_ik-cmd.el
;;     21_javascript.el
;;     99_global-keys.el
;;
;; Files are loaded in the lexicographical order.  This helps you to
;; resolve dependency of the configurations.
;;
;; A platform specific configuration file has a prefix corresponds to
;; the platform.  The following is the list of prefixes and platform
;; specific configuration files are loaded in the listed order after
;; non-platform specific configuration files.
;;
;; Platform   Subplatform        Prefix         Example
;; ------------------------------------------------------------------------
;; Windows                       windows-       windows-fonts.el
;;            Meadow             meadow-        meadow-commands.el
;; ------------------------------------------------------------------------
;; Mac OS X   Carbon Emacs       carbon-emacs-  carbon-emacs-applescript.el
;;            Cocoa Emacs        cocoa-emacs-   cocoa-emacs-plist.el
;; ------------------------------------------------------------------------
;; GNU/Linux                     linux-         linux-commands.el
;; ------------------------------------------------------------------------
;; All        Non-window system  nw-            nw-key.el
;;
;; If `init-loader-byte-compile' is non-nil, each configuration file
;; is byte-compiled when it is loaded.  If you modify the .el file,
;; then it is recompiled next time it is loaded.
;;
;; Loaded files and errors during the loading process are recorded.
;; If `init-loader-show-log-after-init' is non-nil, the record is
;; shown after the overall loading process.  You can do this manually
;; by M-x init-loader-show-log.




