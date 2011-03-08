
(require 'mine-mode-ido)

(require 'mine-mode-yas)
(require 'mine-mode-auto-complete)

;; setting for org mode
(require 'mine-mode-org)

;; lua mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)


;;; setting for Rails
(require 'mine-mode-rails)

;; setting for twittering-mode
(require 'mine-mode-twittering)

;; =============================================================================
(provide 'mine-kit-mode)
