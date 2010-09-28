;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-09-28 20:45:24 Tuesday by ryebread>

(defun woman-settings ()
  "Settings for `woman-mode'."
  (setq woman-use-own-frame nil)

  (defun woman-mode-hook-settings ()
    "Settings for `woman-mode'."
    (setq truncate-lines nil))

  (am-add-hooks 'woman-mode-hook 'woman-mode-hook-settings))

(eval-after-load "woman"
  '(woman-settings))

(provide 'mine-help-woman)
