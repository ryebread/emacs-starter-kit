;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-09-29 20:54:39 Wednesday by ryebread>
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories
             (concat dotfiles-dir "mine/vendor/auto-complete/dict"))

(ac-config-default)

;; 不让回车的时候执行`ac-complete',用M-j来执行`ac-complete'
;(eal-define-keys
; 'ac-complete-mode-map
; `(("<return>"   nil)
;   ("RET"        nil)
;   ("M-j"        ac-complete)))

(setq ac-auto-show-menu t
      ac-use-menu-map t
      ac-auto-start t
      ac-dwim t
      ac-candidate-limit ac-menu-height
      ac-quick-help-delay .8
      ac-disable-faces nil)

(ac-flyspell-workaround)

  (set-default 'ac-sources
               '(ac-source-semantic-raw
                 ac-source-yasnippet
                 ac-source-dictionary
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-words-in-same-mode-buffers
                 ac-source-imenu
                 ac-source-files-in-current-dir
                 ac-source-filename))

(add-to-list 'ac-modes 'rhtml-mode)

(provide 'mine-mode-auto-complete)
