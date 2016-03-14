;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;; set up the work C style:
(require 'cc-mode)
;; Offset customizations not in my-c-style
;; This will take precedence over any setting of the syntactic symbol
;; made by a style.
;;(setq c-offsets-alist '((member-init-intro . ++)))

;;Style for OpenBSD? source code, also valid for OpenSSH? and other BSD based OSs source.
(c-add-style "openbsd"
             '("bsd"
               (indent-tabs-mode . t)
               (defun-block-intro . 8)
               (statement-block-intro . 8)
               (statement-case-intro . 8)
               (substatement-open . 4)
               (substatement . 8)
               (arglist-cont-nonempty . 4)
               (inclass . 8)
               (knr-argdecl-intro . 8)))

;;Bring in Google C Style for fun
(if (locate-library "google-c-style")
    (progn
      (autoload 'google-c-style "google-c-style" "Start Google C Style" t)
      ;;(require 'google-c-style)
      )
  )


(defconst work-old-c-style
  '((c-tab-always-indent . t)
    (indent-tabs-mode . nil) ;; this will make sure spaces are used instead of tabs
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open before after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (defun-open . 0)
                                   (defun-block-intro  . +)
                                   (substatement-open . 0)
                                   (func-decl-cont . 0)
                                   (statement-block-intro . +)
                                   (statement . 0)
                                   (case-label . +)
                                   (statement-case-intro . +)
                                   (do-while-closure . +)
                                   (brace-list-open . 0)
                                   (brace-list-close . 0)
                                   (brace-list-intro . +)
                                   (brace-list-entry . 0)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . nil))
  "Old Work Style.")
(c-add-style "work-old" work-old-c-style)

(defconst work-c-style
  '((c-tab-always-indent . t)
    (indent-tabs-mode . nil) ;; this will make sure spaces are used instead of tabs
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open before after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (defun-open . 0)
                                   (defun-block-intro  . +)
                                   (member-init-intro . +)
                                   (substatement-open . 0)
                                   (func-decl-cont . 0)
                                   (statement-block-intro . +)
                                   (statement . 0)
                                   (label . 0)
                                   (case-label . 0)
                                   (statement-case-intro . +)
                                   (do-while-closure . +)
                                   (brace-list-open . 0)
                                   (brace-list-close . 0)
                                   (brace-list-intro . +)
                                   (brace-list-entry . 0)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . nil))
  "Work Style.")
(c-add-style "work-complex" work-c-style)

;; Customizations for all modes in CC Mode.
(defun work-complex-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "work-complex")
  ;; other customizations
  (setq c-basic-offset 4
        tab-width 8
        )
  ;; this will make sure spaces are used instead of tabs
  ;;(setq indent-tabs-mode nil)
  ;;(make-local-variable 'c-tab-always-indent)
  ;;(setq c-tab-always-indent t)
  ;; we like auto-newline, but not hungry-delete
  ;;(c-toggle-auto-newline 1)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state t)
)
(add-hook 'c-mode-common-hook 'work-complex-c-mode-common-hook)
;;(setq c-default-style "work-complex" )

;;It has been suggested that work style is close to bsd style with offset 4
;;(setq c-default-style "bsd"
;;       indent-tabs-mode nil
;;       c-basic-offset 4)

;;Other modifiers
(setq-default indent-tabs-mode nil)
(setq next-line-add-newlines nil)
(setq font-lock-maximum-decoration t)

;; (set-frame-width (selected-frame) 100)
(setq c-continued-statement-offset t)

;; make gdb show all kinds of info
(setq gdb-many-windows t)

;;;;;White Space Handling
(if (locate-library "whitespace")
    (autoload 'whitespace "whitespace" "Start whitespace" t))
;;(require 'whitespace)
;; remove trailing white space when saving a c file
(add-hook 'c-mode-common-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))
;; show trailing whitespace and tabs in c-mode
(add-hook 'c-mode-common-hook
          (lambda()
            (setq show-trailing-whitespace t)))

;; highlight TODO, etc
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\|TBD\\|MFB\\):" 1 font-lock-warning-face t)))))

;;Activate Electric Indent Mode for C/C++, handles indenting of code in emacs 24.1+ default in 24.4
(when (fboundp 'electric-indent-mode)
  (add-hook `c-mode-common-hook `electric-indent-mode)
  )

(defun fix-c-indent-offset-according-to-syntax-context (key val)
  ;; remove the old element
  (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
  ;; new value
  (add-to-list 'c-offsets-alist '(key . val)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              ;; indent
              (fix-c-indent-offset-according-to-syntax-context 'substatement 0)
              (fix-c-indent-offset-according-to-syntax-context 'func-decl-cont 0))
            ))

