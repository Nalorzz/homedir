;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;;Find fonts using common lisp, return first available font
;; (require 'cl)
;;   (defun font-candidate (&rest fonts)
;;      "Return existing font which first match."
;;      (find-if (lambda (f) (find-font (font-spec :name f))) fonts))

;;Find fonts using dash,  return first available font
(if (locate-library "dash")
    (progn
      (require 'dash)
      (defun font-candidate (&rest fonts)
        "Return the first available font."
        (--first (find-font (font-spec :name it)) fonts))

      ;; Set the font
      (when graphicalp
        ;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))
        ;;(add-to-list 'default-frame-alist '(font . "Source Code Pro-9"))
        ;; Emacs23 style font setting.
        ;; (set-face-attribute 'default nil :font (font-candidate '"Source Code Pro-9:weight=normal" 
        ;;                                                        "DejaVu Sans Mono-9:weight=normal"))
        (set-face-attribute 'default nil :font (font-candidate '"Source Code Pro:weight=normal" 
                                                               "DejaVu Sans Mono:weight=normal"))
        ;;The value is in 1/10pt, so 100 will give you 10pt, etc.
        (set-face-attribute 'default nil :height 90)

        )
      ))
