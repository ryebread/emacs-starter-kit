;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-10-11 20:24:49 Monday by ryebread>

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
      ;; ac-candidate-limit ac-menu-height
      ac-quick-help-delay .8
      ac-disable-faces nil)

(ac-flyspell-workaround)

(set-default 'ac-sources
             '(ac-source-semantic-raw
               ac-source-yasnippet      ;not repeat then yasnippet prio
               ac-source-abbrev
               ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))

(add-to-list 'ac-modes 'rhtml-mode)

(provide 'mine-mode-ac)
