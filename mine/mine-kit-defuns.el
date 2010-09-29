;; Useful Functions for day to day use
;; =============================================================================

;; function to implement a smarter TAB (EmacsWiki)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          (hippie-expand nil)
        (indent-for-tab-command)))))

;; =============================================================================

;; function to Copy-only instead of kill (reddit comments)
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;;;###autoload
(defun smart-copy (arg)
  "智能拷贝, 如果`mark-active'的话, 则`copy-region', 否则`copy-lines'"
  (interactive "p")
  (if mark-active (call-interactively 'copy-region-as-kill)
    (call-interactively 'copy-line arg)))
;; =============================================================================

;; function for moving a buffer and assoc file to new directory - Steve Yegge
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil)     t))))
;; =============================================================================

;; function for renaming a buffer and the associated file - Steve Yegge
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
;; =============================================================================

;; function to display Tip of the Day
(defconst animate-n-steps 3)
(require 'cl)
(random t)
(defun totd ()
  (interactive)
  (let* ((commands (loop for s being the symbols
                         when (commandp s) collect s))
         (command (nth (random (length commands)) commands)))
    (animate-string (concat ";; Initialization successful, welcome to "
                            (substring (emacs-version) 0 16)
                            "\n"
                            "Your tip for the day is:\n========================\n\n"
                            (describe-function command)
                            (delete-other-windows)
                            "\n\nInvoke with:\n\n"
                            (where-is command t)
                            (delete-other-windows)
                            )0 0)))
;; =============================================================================

;; Function to launch a google search
(defun google ()
  "googles a query or a selected region"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Query: ")))))
;; ===============================================================================

;; From stackoverflow - function to compare with auto save data
(defun ediff-auto-save ()
  "Ediff current file and its auto-save pendant."
  (interactive)
  (let ((auto-file-name (make-auto-save-file-name))
        (file-major-mode major-mode))
    (ediff-files buffer-file-name auto-file-name)
    (switch-to-buffer-other-window (file-name-nondirectory auto-file-name))
    (apply file-major-mode '())
    (other-window 1))) ;; back to ediff panel
;; =============================================================================

;; Function to mark complete word, and expand to sentence etc.
;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))

;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun extend-selection (arg &optional incremental)
  "Select the current word.
Subsequent calls expands the selection to larger semantic unit."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))

;(global-set-key (kbd "M-8") 'extend-selection)
;; =============================================================================

;;;###autoload
(defun my-kill-word ()
  "删除一个单词, 当光标处于单词中间时也删除整个单词, 这是与`kill-word'的区别"
  (interactive)
  (wcy-mark-some-thing-at-point)
  (backward-kill-word-or-kill-region))


;; =============================================================================

;; 删除当前光标到行首的字符
;;;###autoload
(defun del-to-begin (&optional arg)
  "Delete characters to line beginning."
  (interactive "P")
  (if (not arg)
      (kill-line 0)
    (copy-region-as-kill-nomark (1+ (line-beginning-position)) (point))))

;;;###autoload
(defun smart-kill ()
  "If `mark-active', call `kill-region', otherwise call `kill-whole-line'."
  (interactive)
  (if mark-active
      (call-interactively 'kill-region)
    (call-interactively 'kill-whole-line)))

;; =============================================================================

;;;###autoload
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'qiang-comment-dwim-line)

;; =============================================================================

;;;###autoload
(defun smart-indent ()
  "If `mark-active', call `indent-region', otherwise indent all buffer."
  (interactive)
  (save-excursion
    (unless mark-active
      (call-interactively 'mark-whole-buffer))
    (call-interactively 'indent-region)))

;; =============================================================================

;;;###autoload
(defun open-line-before ()
  "Insert a newline before cur line and leave point before it.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1)
  (indent-for-tab-command))


;;;###autoload
(defun open-line-after ()
  "Insert a newline after cur line and leave point before it.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive)
  (move-end-of-line 1)
  (open-line 1)
  (forward-char)
  (indent-for-tab-command))

;; =============================================================================
;; 删除一些临时的buffers
(defvar my-clean-buffers-names
  '("\\*Completions" "\\*Compile-Log" "\\*.*[Oo]utput\\*$"
    "\\*Apropos" "\\*compilation" "\\*Customize" "\\*Calc""\\keywiz-scores"
    "\\*BBDB\\*" "\\*trace of SMTP" "\\*vc" "\\*cvs" "\\*keywiz"
    "\\*WoMan-Log" "\\*tramp" "\\*desktop\\*" "\\*Async Shell Command"
    "\\*Backtrace\\*"
     )  "List of regexps matching names of buffers to kill.")

(defvar my-clean-buffers-modes
  '(help-mode Info-mode not-loaded-yet)
  "List of modes whose buffers will be killed.")

(defun my-clean-buffers ()
  "Kill buffers as per `my-clean-buffer-list' and `my-clean-buffer-modes'."
  (interactive)
  (let (string buffname)
    (mapc (lambda (buffer)
              (and (setq buffname (buffer-name buffer))
                   (or (catch 'found
                         (mapc '(lambda (name)
                                    (if (string-match name buffname)
                                        (throw 'found t)))
                                 my-clean-buffers-names)
                         nil)
                       (save-excursion
                         (set-buffer buffname)
                         (catch 'found
                           (mapc '(lambda (mode)
                                      (if (eq major-mode mode)
                                          (throw 'found t)))
                                   my-clean-buffers-modes)
                           nil)))
                   (kill-buffer buffname)
                   (setq string (concat string
                                        (and string ", ") buffname))))
            (buffer-list))
    (if string (message "Deleted: %s" string)
      (message "No buffers deleted"))))

;; ===============================================================================
;; 方便的切换major mode
(defvar switch-major-mode-last-mode nil)

(defun major-mode-heuristic (symbol)
  (and (fboundp symbol)
       (string-match ".*-mode$" (symbol-name symbol))))

(defun switch-major-mode (mode)
  "切换major mode"
  (interactive
   (let ((fn switch-major-mode-last-mode) val)
     (setq val
           (completing-read
            (if fn (format "切换major-mode为(缺省为%s): " fn) "切换major mode为: ")
            obarray 'major-mode-heuristic t nil nil (symbol-name fn)))
     (list (intern val))))
  (let ((last-mode major-mode))
    (funcall mode)
    (setq switch-major-mode-last-mode last-mode)))
(global-set-key (kbd "C-x q") 'switch-major-mode)

(defun get-mode-name ()
  "显示`major-mode'及`mode-name'"
  (interactive)
  (message "major-mode为%s, mode-name为%s" major-mode mode-name))


;; ===============================================================================

(defun count-brf-lines (&optional is-fun)
  "显示当前buffer或region或函数的行数和字符数"
  (interactive "P")
  (let (min max)
    (if is-fun
        (save-excursion
          (beginning-of-defun) (setq min (point))
          (end-of-defun) (setq max (point))
          (message "当前函数%s内共有%d行, %d个字符" (which-function) (count-lines min max) (- max min)))
      (if mark-active
          (progn
            (setq min (min (point) (mark)))
            (setq max (max (point) (mark))))
        (setq min (point-min))
        (setq max (point-max)))
      (if (or (= 1 (point-min)) mark-active)
          (if mark-active
              (message "当前region内共有%d行, %d个字符" (count-lines min max) (- max min))
            (message "当前buffer内共有%d行, %d个字符" (count-lines min max) (- max min)))
        (let ((nmin min) (nmax max))
          (save-excursion
            (save-restriction
              (widen)
              (setq min (point-min))
              (setq max (point-max))))
          (message "narrow下buffer内共有%d行, %d个字符, 非narrow下buffer内共有%d行, %d个字符"
                   (count-lines nmin nmax) (- nmax nmin) (count-lines min max) (- max min)))))))

;; ===============================================================================

(provide 'mine-kit-defuns)
