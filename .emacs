(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(powerline-active1 ((t (:inherit mode-line :background "#bada55"))))
 '(powerline-active2 ((t (:inherit mode-line :background "grey60"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "plum"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "white"))))
 '(rainbow-delimiters-depth-1-face ((((background dark)) (:foreground "White"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "Blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "Brown"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "darkgreen"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Magenta"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "Orange"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "Purple"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "royalblue"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "Red"))))
 '(web-mode-symbol-face ((t (:foreground "blue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying-when-linked t)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(echo-keystrokes 0.1)
 '(emmet-indentation 2)
 '(emmet-preview-default nil)
 '(enable-recursive-minibuffers t)
 '(inhibit-startup-screen t)
 '(jira-url "https://jira.huit.harvard.edu/rpc/xmlrpc")
 '(minibuffer-depth-indicate-mode t)
 '(org-capture-templates (quote (("n" "Notes" entry (file+datetree "~/.emacs.d/orgnotes.org") "* %^{Description} %^g %?
Added: %U"))))
 '(org-src-fontify-natively t)
 '(reb-re-syntax (quote string))
 '(save-place-file "~/.emacs.d/saved-places")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(wdired-allow-to-change-permissions t)
 '(wdired-confirm-overwrite t)
 '(minibuffer-depth-indicate-mode t)
 )

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))

;; Don't run elnode till I want it
;; Doesn't work in customize, must be set pre-package
(setq elnode-do-init nil)

;; Ask before exit
(defun dave-dont-kill-it () (interactive) (if (y-or-n-p-with-timeout "Do you really want to kill Emacs? You LOVE Emacs! " 5 nil) (save-buffers-kill-emacs) (message "")))
(when window-system (global-set-key (kbd "C-x C-c") 'dave-dont-kill-it))

(setq locate-command "mdfind")

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "~/.emacs.d/")

(setq user-full-name "Dave Mayo"
      user-mail-address "dave_mayo@harvard.edu")

(setq tetris-score-file "~/.emacs.d/tetris-scores")

(savehist-mode t)
(require 'saveplace)
(setq-default save-place t)
;; I quite like perma-scratch
(defvar persistent-scratch-filename
  "~/.emacs.d/*scratch*"
  "Location of *scratch* file contents")
(defun save-persistent-scratch ()
  "Write the contents of *scratch* to the file name PERSISTENT-SCRATCH-FILENAME"
  (if (get-buffer "*scratch*")
      (with-current-buffer (get-buffer "*scratch*")
        (write-region (point-min) (point-max)
                      persistent-scratch-filename))))
(defun load-persistent-scratch ()
  "Load the contents of *scratch* from the file name PERSISTENT-SCRATCH-FILENAME"
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (insert-file-contents persistent-scratch-filename))))

(load-persistent-scratch)
(push #'save-persistent-scratch kill-emacs-hook)

;; ibuffer groups
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Special"
                (name . "^\\*.*\\*"))
               ;; ("Vivoom-app"
               ;;  (filename . "vivoom-app/"))
               ;; ("API Test"
               ;;  (filename . "vivoom-api-test/"))
               ("Deft" ;; Deft-buffers
                (mode . deft-note-mode))
               ("Org" ;; all org-related buffers
                (mode . org-mode))
               ("Programming" ;; prog stuff not already in MyProjectX
                (or
                 (mode . c-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)
                 (mode . php-mode)
                 (mode . javascript-mode)
                 (mode . ruby-mode)
                 ;; etc
                 ))
               ("ERC"   (mode . erc-mode))))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

;; Set face before manipulating frame size, stupid
;(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 150 :weight 'normal)
;(set-face-attribute 'default nil :family "Droid Sans Mono Slashed" :height 140 :weight 'normal)
;(set-face-attribute 'default nil :family "Inconsolata" :height 150 :weight 'normal)
(set-face-attribute 'default nil :family "Source Code Pro" :height 125 :weight 'normal)
(set-fontset-font "fontset-default" 'unicode "Monaco")

; Stop forcing me to spell out "yes"
(fset 'yes-or-no-p 'y-or-n-p)

; Backups in single dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

; gnupgp interface
(epa-file-enable)

; Password file is read-only on open
(add-hook 'find-file-hook
          '(lambda () (when (string= (buffer-file-name) "/Users/dave/GarbageTruck.org.gpg")
                        (toggle-read-only 1))))

(when (display-graphic-p)
  ;; "Custom" frame-size management nonsense
  (require 'fgeo)
)

;; Recent Files Mode
(require 'recentf)
(add-to-list 'recentf-exclude ".ido.last\\'")
(add-to-list 'recentf-exclude ".emacs\\'")
(add-to-list 'recentf-exclude ".deft/.*.org\\'")
(add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
(add-to-list 'recentf-exclude "TAGS\\'")
(recentf-mode 1)
(setq recentf-max-menu-items 40)
(setq recentf-max-saved-items 50)
(defun recentf-interactive-complete ()
  "find a file in the recently open file using ido for completion"
  (interactive)
  (let* ((all-files recentf-list)
	 (file-assoc-list (mapcar (lambda (x) (cons (file-name-nondirectory x) x)) all-files))
	 (filename-list (remove-duplicates (mapcar 'car file-assoc-list) :test 'string=))
	 (ido-make-buffer-list-hook
	  (lambda ()
	    (setq ido-temp-list filename-list)))
	 (filename (ido-read-buffer "Find Recent File: "))
	 (result-list (delq nil (mapcar (lambda (x) (if (string= (car x) filename) (cdr x))) file-assoc-list)))
	 (result-length (length result-list)))
         (find-file
	  (cond
	   ((= result-length 0) filename)
	   ((= result-length 1) (car result-list))
	   ( t
	     (let ( (ido-make-buffer-list-hook
		     (lambda ()
		       (setq ido-temp-list result-list))))
	       (ido-read-buffer (format "%d matches:" result-length))))
	   ))))

(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-x M-r") 'recentf-interactive-complete)

(add-hook 'package-menu-mode-hook 'buffer-disable-undo)

;;; package.el related code
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(mapc (lambda (package)
        (or (package-installed-p package)
            (package-install package)))
      '(ace-jump-mode ack-and-a-half ack-menu ag browse-kill-ring creole dash db deft diminish el-x elnode elscreen emmet-mode evil exec-path-from-shell fakir feature-mode findr flx-ido git-commit-mode git-rebase-mode goto-chg goto-last-change haml-mode helm helm-ag helm-cmd-t htmlize iedit inf-ruby inflections jabber jira jump kv lacarte mag-menu magit markdown-mode markdown-mode+ minimap multiple-cursors noflet org-plus-contrib package-utils pcre2el php-mode powerline rainbow-delimiters rinari robe ruby-compilation rvm s scss-mode show-css smartscan smex splitter undo-tree vline web web-mode wgrep wgrep-ack wgrep-ag xml-rpc yaml-mode yasnippet))
;;; End package.el related code

(powerline-default-theme) ;; Do after packages
(rvm-use-default)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(global-smartscan-mode t)
(defun suppress-smartscan () (smartscan-mode -1))
(add-hook 'comint-mode-hook 'suppress-smartscan)
(add-hook 'magit-mode-hook 'suppress-smartscan)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; (global-undo-tree-mode t)
;; (diminish 'undo-tree-mode)

(require 'helm-cmd-t)
(helm-mode t)
(diminish 'helm-mode)

(defvar my-mini-folders (list  "~/" "~/Inscriptio")
  "my permanent folders for helm-mini")

(defun helm-my-mini (&optional arg)
  "my helm-mini.  Use C-u arg to work with repos."
  (interactive "P")
  (if (consp arg)
      (call-interactively 'helm-cmd-t-repos)
    (let ((helm-ff-transformer-show-only-basename nil))
      (helm :sources (nconc (list
                             helm-source-buffers-list
                             helm-source-recentf)
                            (mapcar (lambda (dir)
                                      (helm-cmd-t-get-create-source-dir dir))
                                    my-mini-folders)
                            (list
                             helm-source-buffer-not-found)
                            )
            :candidate-number-limit 20
            :buffer "*helm-my-mini:*"))))

(global-set-key (kbd "H-x H-f") 'helm-my-mini)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (global-set-key (kbd "C-z") nil) ;; Stop minimize
  ;; Use coreutils version of ls if available for --dired
  (when (= (shell-command "type gls") 0)
    (setq ls-lisp-use-insert-directory-program t)
    (setq insert-directory-program "gls")))

(global-rainbow-delimiters-mode t) ;; Pretty Colors!

(require 'cl)
(require 's)

;; Slime
;;(add-to-list 'load-path "/Users/pobocks/.emacs.d/slime/")  ; your SLIME directory
;;(require 'slime)
;;(slime-setup '(slime-fancy))
;;(setq slime-lisp-implementations
;;      '((sbcl ("sbcl" "--core" "/Users/pobocks/.emacs.d/slime/sbcl.core-for-slime"))
;;        (clisp ("clisp") :coding-system utf-8-unix)))
;;
;;(setq slime-default-lisp 'sbcl)
;;(define-key slime-mode-map (kbd "H-<tab>") 'slime-complete-symbol)
;;(require 'cldoc)
;;(autoload 'turn-on-cldoc-mode "cldoc" nil t)
;;(dolist (hook '(lisp-mode-hook
;;                slime-repl-mode-hook))
;;  (add-hook hook 'turn-on-cldoc-mode))

;; Editing grep buffer results
(require 'wgrep)
(require 'wgrep-ag)

(setq vc-handled-backends nil)
(setq c-default-style
      `((other . "k&r")))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default tab-stop-list (list 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54))
(setq-default standard-indent 2)
(setq-default c-basic-offset 2)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-close 'c-lineup-arglist-operators)
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)
(setq js-indent-level 2)

(setq ns-right-alternate-modifier nil)

(require 'find-dired)
(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

(cua-mode 0)
(transient-mark-mode 0)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key (kbd "H-f") 'show-file-name)

(setq grep-command "grep -nHP -e "
      grep-find-template "find . <X> -type f <F> -exec grep <C> -nHP -e <R> {} /dev/null \\;")
(defun grep-occur (regexp &optional nlines)
  (interactive (occur-read-primary-args))
  (save-some-buffers)
  (grep (concat grep-command
                (shell-quote-argument regexp)
                (if nlines
                    (if (> nlines 0)
                        (format " -C %d " nlines)
                      (format " -B %d " (abs nlines)))
                  " ")
                (buffer-file-name))))
(winner-mode 1)

(setq-default ns-right-control-modifier 'hyper)

(global-set-key (kbd "H-SPC") 'ace-jump-mode)
(global-set-key (kbd "H-S-SPC") 'ace-jump-line-mode)

;(defun hyperspace () (interactive) (progn (find-file "/scpc:qs2970.pair.com:~/public_html/genarts-davemayo")(message "Engage!")))
;(global-set-key (kbd "H-SPC") 'hyperspace)

(require 'vc-git)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(moz-minor-mode 1)
(defvar browser-y-offset 0)
(defun get-browser-offset (output) (if (not (= (string-to-number output) 0))
                                       (setq browser-y-offset (string-to-number output))) output)
(add-hook 'comint-preoutput-filter-functions 'get-browser-offset)
(global-set-key (kbd "H-v")
                (lambda () (interactive)
                  (comint-send-string (inferior-moz-process) "window.content.scrollByPages(1);")))
(global-set-key (kbd "H-V")
                (lambda () (interactive)
                  (comint-send-string (inferior-moz-process) "window.content.scrollByPages(-1);")))
(global-set-key (kbd "H-n")
                (lambda (arg) (interactive "p")
                  (comint-send-string
                   (inferior-moz-process)
                   (concat "for (var i = 0;i < " (number-to-string (abs arg)) "; i++) {gBrowser.tabContainer.advanceSelectedTab(1, true);}"))))
(global-set-key (kbd "H-p")
                (lambda (arg) (interactive "p")
                  (comint-send-string
                   (inferior-moz-process)
                   (concat "for (var i = 0; i < " (number-to-string (abs arg)) "; i++) {gBrowser.tabContainer.advanceSelectedTab(-1, true);}"))))
(global-set-key (kbd "H-g")
                (lambda () (interactive)
                  (comint-send-string
                   (inferior-moz-process)
                   (concat "window.content.location.href='"
                           (let ((x (read-from-minibuffer "Go To: ")))
                             (if (string= (substring x 0 7) "http://")
                                 x
                               (concat "http://" x))) "';"))))

(global-set-key (kbd "s-r")
                (lambda () (interactive)
                  (comint-send-string (inferior-moz-process) "BrowserReload();")))
(global-set-key (kbd "s-R")
                (lambda () (interactive)
                  (comint-send-string (inferior-moz-process) "window.content.pageYOffset;")
                  (let ((local-y browser-y-offset))
                    (message (number-to-string local-y))
                    (comint-send-string
                     (inferior-moz-process) "BrowserReloadWithFlags([nsIWebNavigation.LOAD_FLAGS_BYPASS_CACHE]);")
                    (sit-for 5)
                    (comint-send-string
                     (inferior-moz-process) (concat "window.content.scrollTo(0," (number-to-string local-y) ");"))
                    )))
(require 'windmove)
(require 'emacsd-tile)

(require 'outline)
;(setq load-path (cons "~/.emacs.d/org/lisp" load-path))
;(setq load-path (cons "~/.emacs.d/org/contrib/lisp" load-path))
(require 'org-install)

(defun org-export-latex-no-toc (depth)
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
  (setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

(require 'ox-latex)
(setq org-latex-classes (append org-latex-classes
             '(("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}"))
               ("koma-article"
                "\\documentclass{scrartcl}"
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))

;; Kill server buffers just like regular buffers
(global-set-key (kbd "C-x k")
                (lambda ()
                  (interactive)
                  (if server-buffer-clients
                      (server-edit)
                    (kill-this-buffer))))

(load "server")
(unless (server-running-p) (server-start))

;; Deft
(setq deft-use-filename-as-title t)
(define-minor-mode deft-note-mode "Deft notes" nil " Deft-Notes" nil)
(setq deft-text-mode 'deft-note-mode)
(setq deft-extension "org")
(defun kill-all-deft-notes ()
  (interactive)
  (save-excursion
    (let((count 0))
      (dolist(buffer (buffer-list))
        (set-buffer buffer)
        (when (not (eq nil deft-note-mode))
          (setq count (1+ count))
          (if (buffer-modified-p buffer) (save-buffer buffer))
          (kill-buffer buffer)))
      )))
(defun deft-or-close () (interactive) (if (or (eq major-mode 'deft-mode) (not (eq nil deft-note-mode)))
                                          (progn (kill-all-deft-notes) (kill-buffer "*Deft*"))
                                        (deft)
                                        ))
(global-set-key [f6] 'deft-or-close)

;; Load CSS-Mode
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-mirror-mode nil)
(setq cssm-indent-level 2)
(setq css-indent-offset 2)

(defun yank-pop-forwards (arg) (interactive "p") (yank-pop (- arg)))
(global-set-key (kbd "M-Y") 'yank-pop-forwards)

(put 'narrow-to-region 'disabled nil)

(setq ediff-split-window-function 'split-window-horizontally)

;; ido stuff
(ido-mode 1)
(require 'flx-ido)
(ido-mode 1)
(setq gc-cons-threshold 20000000)
;; disable ido faces to see flx highlights.
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(add-to-list 'ido-ignore-buffers "^\*helm.*")
(add-to-list 'ido-ignore-buffers "^\*Messages\*")
(global-set-key (kbd "C-x 4 C-f") 'ido-find-file-other-window)

;; smex - ido-style M-x
;(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;Tab expands in eval-expression
(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)

;Occur keybinding in isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(defun isearch-forward-region-cleanup ()
  "turn off variable, widen"
  (if isearch-forward-region
      (widen))
  (setq isearch-forward-region nil))
(defvar isearch-forward-region nil
  "variable used to indicate we're in region search")
(add-hook 'isearch-mode-end-hook 'isearch-forward-region-cleanup)
(defun isearch-forward-region (&optional regexp-p no-recursive-edit)
  "Do an isearch-forward, but narrow to region first."
  (interactive "P\np")
  (narrow-to-region (point) (mark))
  (goto-char (point-min))
  (setq isearch-forward-region t)
  (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))

(global-set-key (kbd "C-H-s") 'isearch-forward-region)

(defun isearch-backward-region-cleanup ()
  "turn off variable, widen"
  (if isearch-backward-region
      (widen))
  (setq isearch-backward-region nil))
(defvar isearch-backward-region nil
  "variable used to indicate we're in region search")
(add-hook 'isearch-mode-end-hook 'isearch-backward-region-cleanup)
(defun isearch-backward-region (&optional regexp-p no-recursive-edit)
  "Do an isearch-backward, but narrow to region first."
  (interactive "P\np")
  (narrow-to-region (point) (mark))
  (goto-char (point-max))
  (setq isearch-backward-region t)
  (isearch-backward (not (null regexp-p)) (not no-recursive-edit)))
(global-set-key (kbd "C-H-r") 'isearch-backward-region)

(setq undo-limit 10000000)
(setq undo-strong-limit 20000000)
(setq undo-outer-limit 30000000)

(add-to-list 'auto-mode-alist '(".*\\.\\(php\\|module\\|inc\\|test\\|install\\)$" . php-mode))
(defun turn-off-auto-fill () (interactive) (auto-fill-mode -1))
(setq text-mode-hook (append text-mode-hook '(turn-off-auto-fill)))
(require 'which-func)
(add-to-list 'which-func-modes 'php-mode)

;; Delete trailing whitespace - disable for deft to avoid being flustered by autosave
(defun delete-trailing-except-deft () (interactive) (when (eq nil deft-note-mode) (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'delete-trailing-except-deft)

(require 'tramp)
(tramp-set-completion-function "ssh"
           '((tramp-parse-sconfig "/etc/ssh_config")
             (tramp-parse-sconfig "~/.ssh/config")))
(tramp-set-completion-function "scpc"
           '((tramp-parse-sconfig "/etc/ssh_config")
             (tramp-parse-sconfig "~/.ssh/config")))

(setq scss-compile-at-save nil)
(setq scss-sass-command "/Users/pobocks/.rvm/gems/ruby-1.9.3-p327/bin/sass")
(require 'snippet)
(require 'rinari)
;;(global-rinari-mode)

;; Forward/Backward by sexp bindings for arrow keys in ruby
(define-key ruby-mode-map (kbd "C-M-<left>") 'ruby-backward-sexp)
(define-key ruby-mode-map (kbd "C-M-<right>") 'ruby-forward-sexp)

;; (require 'iedit)

;; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key (kbd "C-c c") 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key (kbd "C-c k") 'mode-compile-kill)

;; Miscellaneous Keybinds
(global-set-key (kbd "C-]") 'blink-matching-open)
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C->") 'end-of-buffer)
(global-set-key (kbd "M-/") 'hippie-expand) ;; Trying out hippie-expand
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-RET") 'newline)

;; Open line funcs
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)


(global-set-key (kbd "C-%") 'replace-string)

(global-set-key (kbd "H-t") (lambda () (interactive) (ansi-term "/bin/zsh")))

(global-set-key (kbd "<f5>") 'kmacro-call-macro)

(global-set-key (kbd "C-x SPC") 'pop-to-mark-command)

;; Kill line refinements
(global-set-key (kbd "C-S-k") (lambda () (interactive) (kill-line 0) (indent-for-tab-command)))
(global-set-key (kbd "C-x r M-k") 'copy-rectangle-as-kill)

;; Kill word backward
(global-set-key (kbd "M-D") (lambda (arg) (interactive "p") (kill-word (- arg))))

;; Note: the below is fragile.  M-S-k doesn't work, and in a terminal, only the last one is defined
(global-set-key (kbd "M-K") (lambda () (interactive) (kill-ring-save (line-beginning-position) (point))
                                (message "Line kill-saved backwards")))
(global-set-key (kbd "M-k") (lambda () (interactive) (kill-ring-save (point) (line-end-position))
                              (message "Line kill-saved")))
(put 'set-goal-column 'disabled nil)

;; zap-to-regex
(defun zap-to-regexp (arg regexp)
  "Kill up to but not including ARGTH occurrence of REGEX.
Case is ignored if `case-fold-search' is non-nil in the current buffer.
Goes backward if ARG is negative; error if REGEX not found."
  (interactive (list (prefix-numeric-value current-prefix-arg)
		     (read-regexp "Zap to regexp: " t)))
  (kill-region (point)
               (progn
                 (re-search-forward regexp nil nil arg)
                 (let ((end-loc (if (<= 0 arg) (match-beginning 0) (match-end 0))))
                   (set-window-point nil end-loc)
                   end-loc))))


(global-set-key (kbd "C-M-z") 'zap-to-regexp)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)
