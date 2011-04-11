(defun starter-kit-el-get-install ()
  "Install all starter-kit packages that aren't installed."
  (interactive)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(when (not (load (concat dotfiles-dir "el-get/el-get/el-get") t))
  ;;  (error "Please bootstrap el-get using the instructions here: http://github.com/dimitri/el-get/, then restart Emacs")
  (starter-kit-el-get-install))


(setq
 ;;      el-get-byte-compile nil
 ;;      el-get-generate-autoloads nil
 el-get-sources
 '(el-get
   (:name package24
          :after (lambda ()
             (dolist (source '(("technomancy" . "http://repo.technomancy.us/emacs/")
                               ("elpa" . "http://tromey.com/elpa/")))
               (add-to-list 'package-archives source t))))


   ;; Basics

   ;;         smex
   ;;         ido-hacks
   ;;         maxframe
   ;;         session
   ;;         revive
   ;;         project-local-variables
   ;;         dired-plus
   ;;         scratch
   ;;         diminish
   ;;         autopair
   (:name undo-tree
          :type git :url "http://www.dr-qubit.org/git/undo-tree.git"
          :after (lambda ()
                   (load-library "undo-tree/undo-tree")
                   (global-undo-tree-mode t)))
   ;;         hl-sexp
   ;;         highlight-symbol
   ;;         highlight-parentheses
   ;;         smooth-scrolling
   ;;         fuzzy-format
   ;;         regex-tool
   ;;         todochiku
   ;;         edit-server
   ;;         fringe-helper
   ;;         eol-conversion
   ;;         iedit
   ;;         mwe-log-commands
   ;;         ;(:name all :type http :url "ftp://ftp.dina.kvl.dk/pub/Staff/Per.Abrahamsen/auctex/all.el")
   ;;         lively
   ;;         whole-line-or-region
   ;;         pointback
   ;;         flymake-point
   notify
   (:name idle-highlight :type elpa)
   (:name find-file-in-project :type elpa)
   (:name htmlize :type elpa)

   ;; Completion

   auto-complete
   yasnippet
   smart-tab
   ;;         ac-dabbrev
   ;;         ac-slime

   ;; Cosmetics

   color-theme
   ;;        color-theme-sanityinc
   ;;        color-theme-zenburn
   color-theme-twilight
   color-theme-subdued
   ;;        color-theme-railscasts

   ;;         ;; XML and HTML
   ;;         (:name nxml-html5
   ;;                :type git
   ;;                :url "https://github.com/hober/html5-el.git"
   ;;                :build ("make relaxng")
   ;;                :features whattf-dt
   ;;                :after (lambda ()
   ;;                         (message "nxml-html5: after")
   ;;                         (eval-after-load "rng-loc"
   ;;                           '(add-to-list 'rng-schema-locating-files
   ;;                                         (expand-file-name "schemas.xml"
   ;;                                                           (el-get-package-directory "nxml-html5"))))))

   ;;         ;; Org

   ;;         (:name org-mode :type git :url "git://repo.or.cz/org-mode.git" :load-path ("lisp" "contrib/lisp"))
   ;;         org-fstree

   ;; Ruby & Rails

   ruby-mode
   (:name inf-ruby :type elpa)
   ;;         ruby-compilation
   ;;         rinari
   ;;         ri-emacs
   yaml-mode
   ;;         haml-mode
   ;;         sass-mode
   ;;         rdebug
   (:name cheat :type git :url "https://github.com/defunkt/cheat.el.git") ; for cheat interface
   
   ;; Version control

   magit
   gist
   ;;         magithub
   ;;         git-blame
   ;;         diff-git
   ;;         dsvn
   ;;         vc-darcs
   ;;         darcsum
   ;;         (:name ibuffer-vc :type git :url "https://github.com/purcell/ibuffer-vc.git")

   ;; Lisps
   paredit

   ;;         (:name paredit :type http :url "http://mumble.net/~campbell/emacs/paredit-beta.el" :localname "paredit.el") ; Overridden to get beta version
   ;;         (:name slime :type git :url "git://sbcl.boinkor.net/slime.git" :load-path ("." "./contrib") :compile nil :load "slime-autoloads.el") ; Overridden to prefer git mirror
   ;;         clojure-mode
   ;;         swank-clojure
   ;;         durendal
   ;;         quack

   ;;         crontab-mode
   ;;         mmm-mode

   ;; Apps

   ;;         twit
   ;;         erc
   ;;         ;offlineimap

   ;;         google-weather

   ;; Python: you Should manual install python package-rope,pymacs,pep8,ropemode
   ;;         (:name python-mode :type http :url "http://launchpad.net/python-mode/trunk/5.1.0/+download/python-mode.el") ; Overridden because bzr's lp source breaks with python 2.7 (https://bugs.launchpad.net/bzr/+bug/612096)
   python-mode
   pymacs
   ropemacs
   (:name ipython :type http :url "http://ipython.scipy.org/dist/ipython.el")
   python-pep8
   
   ;; Javascript

   ;;         js2-mode
   ;;         coffee-mode
   ;;         js-comint
   ;;         (:name moz :type http :url "http://github.com/bard/mozrepl/raw/master/chrome/content/moz.el")
   ;;         json

   ;;         ;; Erlang

   ;;         (:name erlware-mode ;; Overridden to use git version
   ;;                :type git :url "https://github.com/erlware/erlware-mode.git"
   ;;                :load "erlang-start.el")

   ;;         ;; PHP

   ;;         php-mode
   ;;         smarty-mode

   ;; CSS
   (:name css-mode :type elpa)

   ;;         rainbow-mode
   ;;         tidy

   ;;         gnuplot-mode
   ;;         csv-mode
   ;;         csv-nav
   markdown-mode
   ;;         textile-mode
   ;;         haskell-mode
   lua-mode
   ))



(defun el-get-overridden ()
  (let* ((global (mapcar 'el-get-source-name (el-get-read-all-recipes))))
    (loop for recipe in el-get-sources
          and name = (el-get-source-name recipe)
          when (and (not (symbolp recipe))
                    (member name global))
          collect name)))

(defun el-get-update-all ()
  "Update all el-get packages"
  (interactive)
  (dolist (package (mapcar 'el-get-source-name el-get-sources))
    (unless (memq (plist-get (el-get-package-def package) :type) '(http-tar elpa))
      (el-get-update package))))


(el-get 'sync)

(provide 'mine-kit-el-get)
