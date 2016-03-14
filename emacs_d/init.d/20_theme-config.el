;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;; color themes load path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory
                                             (convert-standard-filename "themes/")))

;;;;; Themes ;;;;;
;; Solarized Options
;; make the fringe stand out from the background
;;(setq solarized-distinct-fringe-background t)
;; make the modeline high contrast
;;(setq solarized-high-contrast-mode-line t)
;; Use less bolding
;;(setq solarized-use-less-bold t)
;; Use more italics
;;(setq solarized-use-more-italic t)
;; Use less colors for indicators such as git:gutter, flycheck and similar.
;;(setq solarized-emphasize-indicators nil)


;; Cycle through this set of themes
(defvar my-themes '(solarized-light solarized-dark zenburn clarity)
  "The current list of themes.")

(if (eq graphicalp 'nil) 
    (setq my-themes '(clarity solarized-dark solarized-light zenburn))
  )


(defvar my-cur-theme nil
  "The current set theme.")

(defun cycle-my-theme ()
  "Cycle through a list of themes, my-themes"
  (interactive)
  (when my-cur-theme
    (disable-theme my-cur-theme)
    (setq my-themes (append my-themes (list my-cur-theme))))
  (setq my-cur-theme (pop my-themes))
  (load-theme my-cur-theme t))

;; Switch to the first theme in the list above
(cycle-my-theme)

;; Bind this to C-t
(when (fboundp 'cycle-my-theme)
  (global-set-key (kbd "C-t") 'cycle-my-theme)
)
