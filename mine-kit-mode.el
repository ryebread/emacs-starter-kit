(global-smart-tab-mode 1)               ; use smart-tab for completion

;;; setup autocomplet autostart nil,but cat manual start anyway
(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

;;(require 'mine-mode-ido)

;;(require 'mine-mode-yas)
;;(require 'mine-mode-ac)

;; setting for org mode
;;(require 'mine-mode-org)

;; lua mode
;;(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
;;(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; setting for python
(require 'mine-mode-python)

;;; setting for Rails
;;(require 'mine-mode-rails)

;; setting for twittering-mode
;;(require 'mine-mode-twittering)

;; =============================================================================
(provide 'mine-kit-mode)
