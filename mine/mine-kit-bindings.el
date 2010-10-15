;; I need these key combos
;; ===============================================================================
;; key bindings for global fund
(global-set-key (kbd "C-x t") 'twit)
(global-set-key (kbd "C-c c") 'org-capture)

;;; Keybindings for edit
(global-set-key (kbd "%") 'match-paren)

(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)
(global-set-key (kbd "C-2") 'set-mark-command)

(global-set-key (kbd "C-8") 'extend-selection)
(global-set-key (kbd "M-w") 'smart-copy)

(global-set-key (kbd "C-0") 'back-to-indentation)

(global-set-key (kbd "TAB") 'smart-tab)
(global-set-key (kbd "C-M-\\") 'smart-indent)

(global-set-key (kbd "C-o") 'open-line-after)
(global-set-key (kbd "C-S-o") 'open-line-before)
(global-set-key (kbd "S-<return>") 'open-line)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(global-set-key (kbd "C-k") 'smart-kill)
(global-set-key (kbd "C-M-k") 'kill-line)
(global-set-key (kbd "C-S-k") 'del-to-begin)

(global-set-key (kbd "C-j") 'whack-whitespace)
(global-set-key (kbd "M-j") 'fixup-whitespace)
(global-set-key (kbd "C-M-j") 'delete-indentation)

(global-set-key (kbd "M-?") 'redo)

(eal-define-keys-commonly
 global-map
 `(("M-D" my-kill-word)
   ))

;;; buffer relative operation
(global-set-key (kbd "C-x k") 'kill-this-buffer)  ; 立即关闭当前buffer
(global-set-key (kbd "C-x C-k") 'my-clean-buffers) ;删除临时buffers

;; bm(bookmark)bindings
(global-unset-key (kbd "C-1"))
(global-set-key (kbd "C-1 t") 'bm-toggle)
(global-set-key (kbd "C-1 n") 'bm-next)
(global-set-key (kbd "C-1 p") 'bm-previous)

(global-set-key (kbd "C-1 a") 'bm-toggle-cycle-all-buffers)
(global-set-key (kbd "C-1 r") 'bm-bookmark-regexp)
(global-set-key (kbd "C-1 s") 'bm-show-all)
(global-set-key (kbd "C-1 c") 'bm-remove-all-current-buffer)

(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;;; misc key bindings
(global-set-key (kbd "C-h o c") 'describe-char)
(global-set-key (kbd "C-h C-m") 'get-mode-name)
(global-set-key (kbd "C-h C-l") 'count-brf-lines)
(global-set-key (kbd "C-h o p") 'message-point)

(global-set-key (kbd "C-x ESC ESC") 'repeat-complex-command)

(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "C-<f11>") 'toggle-maximize-frame)


;;;
;; (global-set-key (kbd "M-j") 'pop-to-mark-command)
;; (global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
;; (global-set-key (kbd "M-g") 'goto-line)
;; (global-set-key (kbd "C-x n r") 'narrow-to-region)

;;Keybindings from Steve Yegge's Effective Emacs
;; (global-set-key (kbd "C-x C-m") 'execute-extended-command) ;; faster M-x
;; (global-set-key (kbd "C-c C-m") 'execute-extended-command)
;; (global-set-key (kbd "C-w") 'backward-kill-word)           ;; easy editing

;; w3m relative bindings
(eal-define-keys-commonly
 global-map
 `(("M-M"     w3m-goto-url-new-session)
   ("C-x M-B" view-w3m-bookmark)
   ("C-x M-m" switch-to-w3m)
   ("C-x M-c" w3m-browse-current-buffer)))
;; ===============================================================================

(provide 'mine-kit-bindings)
