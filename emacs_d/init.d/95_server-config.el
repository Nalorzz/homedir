;; -*- Mode: Emacs-Lisp -*-
;; -*- lisp -*-

;; Start the Emacs Server
;; Only start the server when running in a GUI
(require 'server)
(if (and window-system (not (server-running-p)))
    (progn
      (server-start)
      )
  )
