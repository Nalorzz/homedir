;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

(if (locate-library "smartparens") ;;smartparens: https://github.com/Fuco1/smartparens
    (progn
      (smartparens-global-mode t)
      (require 'smartparens-config)
      )
)
;;;;;;;;;; Currently not liking th the smartparens show parens, as it does not do mixed
;; show matching parens when cursor is near one
;; (if (fboundp 'show-smartparens-global-mode) ;;smartparens: https://github.com/Fuco1/smartparens
;;     (progn
;;       (setq sp-show-pair-delay 0)       ; how long to wait?
;;       (show-smartparens-global-mode t)  ; turn paren-mode on
;;       (set-face-attribute 'sp-show-pair-match-face nil 
;;                           :weight 'bold :underline nil :overline nil :slant 'normal)
;;       (set-face-attribute 'sp-show-pair-mismatch-face nil 
;;                           :weight 'bold :underline t :overline nil :slant 'normal)
;;       )
;; )

;; http://http://www.emacswiki.org/emacs/ShowParenMode
(when (fboundp 'show-paren-mode)
  (setq show-paren-delay 0)       ; how long to wait?
  (show-paren-mode t)             ; turn paren-mode on
  (setq show-paren-style `mixed)  ; alternatives are 'expression', 'parenthesis' and 'mixed'
  (set-face-attribute 'show-paren-match-face nil 
                      :weight 'bold :underline nil :overline nil :slant 'normal)
  (set-face-attribute 'show-paren-mismatch-face nil 
                      :weight 'bold :underline t :overline nil :slant 'normal)
  (when (locate-library "mic-paren") ;Might remove this when emacs 24.4 comes out
    (require 'mic-paren)
    (paren-activate)
    )
  )
