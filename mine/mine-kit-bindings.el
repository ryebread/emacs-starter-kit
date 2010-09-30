;; I need these key combos
;; ===============================================================================
;;; Keybindings for edit
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)
(global-set-key (kbd "C-2") 'set-mark-command)

(global-set-key (kbd "C-8") 'extend-selection)
(global-set-key (kbd "M-w") 'smart-copy)

(global-set-key (kbd "TAB") 'smart-tab)
(global-set-key (kbd "C-M-\\") 'smart-indent)

(global-set-key (kbd "C-o") 'open-line-after)
(global-set-key (kbd "C-S-o") 'open-line-before)
(global-set-key (kbd "S-<return>") 'open-line)

(global-set-key (kbd "C-k") 'smart-kill)
(global-set-key (kbd "C-M-k") 'kill-line)
(global-set-key (kbd "C-S-k") 'del-to-begin)

(eal-define-keys-commonly
 global-map
 `(
   ("M-D" my-kill-word)
   ("M-Y" redo)
   ("C-0" beginning-of-line-text)
   ))

;;; buffer relative operation
(global-set-key (kbd "C-x k") 'kill-this-buffer)  ; 立即关闭当前buffer
(global-set-key (kbd "C-x C-k") 'my-clean-buffers) ;删除临时buffers

;;; misc key bindings
(global-set-key (kbd "C-h o c") 'describe-char)
(global-set-key (kbd "C-h C-m") 'get-mode-name)
(global-set-key (kbd "C-h C-l") 'count-brf-lines)
(global-set-key (kbd "C-h o p") 'message-point)

(global-set-key (kbd "C-x ESC ESC") 'repeat-complex-command)

(global-set-key (kbd "M-j") 'pop-to-mark-command)
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x n r") 'narrow-to-region)

;;Keybindings from Steve Yegge's Effective Emacs
(global-set-key (kbd "C-x C-m") 'execute-extended-command) ;; faster M-x
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
(global-set-key (kbd "C-w") 'backward-kill-word)           ;; easy editing
(global-set-key (kbd "C-x C-k") 'kill-region)              ;; remapping C-w
;; ===============================================================================

(provide 'mine-kit-bindings)
