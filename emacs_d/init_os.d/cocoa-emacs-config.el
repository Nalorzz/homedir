;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(defun system-specific-setup()
  ;;;;;;;;;;;;;;;;;;;;;add Code here
  ;;OS X Specific
  ;; mac-function-modifier
  ;; mac-control-modifier
  ;; mac-command-modifier
  ;; mac-option-modifier
  ;; mac-right-command-modifier
  ;; mac-right-control-modifier
  ;; mac-right-option-modifier
  ;; values can be 'control (C), 'alt (A), 'meta (M), 'super (s), or 'hyper (H).
  ;; setting to nil allows the OS to assign values

  ;; key bindings
  (when osxp 
    (setq mac-option-modifier 'alt)
    (setq mac-command-modifier 'meta)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    )

  

  )
