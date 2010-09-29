;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-09-29 22:35:48 Wednesday by ryebread>

(require 'rinari)

;;; rhtml-mode
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)
            (setq yas/extra-modes 'ruby-mode)))

(provide 'mine-mode-rails)
