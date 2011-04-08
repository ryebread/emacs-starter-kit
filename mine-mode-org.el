
(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/notes.org")
(setq org-agenda-files '("~/org/gtd.org"))
(setq org-refile-targets
      (quote (("gtd.org" :maxlevel . 1) ("someday.org" :level . 2))))


(setq org-log-done t)
(setq org-agenda-include-diary nil)
(setq org-deadline-warning-days 7)
(setq org-timeline-show-empty-dates t)
(setq org-insert-mode-line-in-empty-file t)
(setq org-fast-tag-insert t)
;; (setq org-fast-tag-selection-include-todo t)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n")
        ("n" "Note" entry (file+datetree "~/org/notes.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-agenda-custom-commands
      '(
        ("p" "Projects"
         ((tags "PROJECT")))
        ("h" "Office and Home Lists"
         ((agenda)
          (tags-todo "OFFICE")
          (tags-todo "HOME")
          (tags-todo "COMPUTER")
          ))

        ("d" "Daily Action List"
         (
          (agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))))

(setq org-todo-keywords '((sequence "TODO" "STARTED" "DONE")))

(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org"))
(global-set-key (kbd "C-c g") 'gtd)

;; =============================================================================
(provide 'mine-mode-org)
