; my misc customizations for emacs
; ==============================================================================

(setq user-full-name "ryebread"
      user-mail-address "hhdslb@gmail.com")

(setq delete-selection-mode t
      debug-on-error t)

(setq bookmark-default-file "~/.emacs.d/bookmarks.bmk"
      bookmark-save-flag 1) ;; save my bookmarks as soon as I create them

(setq-default ispell-program-name "aspell")

;; Completion ignores filenames ending in any string in this list.
;; TODO: replace this setq with an add-to-list. Why destroy the
;; earlier completion-ignored-extensions?
(setq completion-ignored-extensions
   '(".o" ".elc" "~" ".bin" ".class" ".exe" ".ps" ".abs" ".mx" ".~jv" ".rbc"))

;; delete trailing whitespace in files
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defvar programming-major-modes
  '(js2-mode c-mode c++-mode conf-mode clojure-mode)
  "List of programming modes")

(defun mine/prog-mode-settings ()
  "special settings for programming modes."
  (when (memq major-mode programming-major-modes)
    ;; No stray edits.Toggle with (C-x C-q) if I want to make an edit
    (toggle-read-only 1)
    ;; Flyspell mode for comments and strings
    (flyspell-prog-mode)))

(add-hook 'find-file-hook 'mine/prog-mode-settings)

;; Indentation hook for C/C++ mode
;; As defined in Documentation/CodingStyle
(defun mine/linux-c-indent ()
  "adjusted defaults for C/C++ mode use with the Linux kernel."
  (interactive)
  (setq tab-width 8)
  (setq indent-tabs-mode nil) ;; force spaces, to work with dumber editors
  (setq c-basic-offset 8))

(add-hook 'c-mode-hook 'mine/linux-c-indent)
(add-hook 'c-mode-hook (lambda() (c-set-style "K&R")))
(add-hook 'c++-mode-hook 'vedang/linux-c-indent)

;; these are configuration files and should be opened in appropriate mode
(add-to-list 'auto-mode-alist '("\\.\\(mc\\|rc\\|def\\)$" . conf-mode))

;; customizations for auto-indentation
(defadvice yank (after indent-region activate)
  (if (member major-mode programming-major-modes)
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode programming-major-modes)
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

;; settings for hippie-expand
(setq hippie-expand-try-functions-list
       '(try-expand-dabbrev
         try-expand-dabbrev-from-kill
         try-expand-dabbrev-all-buffers
         try-complete-file-name-partially
         try-complete-file-name
         try-complete-lisp-symbol-partially
         try-complete-lisp-symbol))

;; uniquify settings
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Aliases for common functions
;(defalias 'qrr 'query-replace-regexp)
;(defalias 'rvt 'revert-buffer)
;(defalias 'dtw 'delete-trailing-whitespace)

;; Enable narrow-to-region, extremely useful for editing text
(put 'narrow-to-region 'disabled nil)

;; load font-set
(require 'mine-misc-fontset)

;; load this color-theme
(color-theme-twilight)

;; visual-line is good to have
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
; ==============================================================================

(provide 'mine-kit-misc)
