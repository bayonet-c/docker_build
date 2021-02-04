

(defconst *is-mac* (eq system-type 'darwin)) 
(defconst *is-linux* (eq system-type 'gnu/linux)) 
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "customize")))
(setq custom-file 
      (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8) 
(set-terminal-coding-system 'utf-8) 
(set-keyboard-coding-system 'utf-8) 
(setq default-buffer-file-coding-system 'utf-8)

(setq gc-cons-threshold most-positive-fixnum)  ;; Gabage collection

(menu-bar-mode -1) 
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)        ; Give some breathing room
(setq inhibit-startup-screen t)
(setq make-backup-files nil)

(require 'package)
   
(setq package-archives '(
    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
    ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq package-check-signature nil) ; By-pass signature checking failure
(unless (bound-and-true-p package--initialized) 
    (package-initialize))
(unless package-archive-contents
    (package-refresh-contents))

(unless (package-installed-p 'use-package) 
    (package-refresh-contents) 
    (package-install 'use-package))

(require 'use-package)
(eval-and-compile
  (setq use-package-always-ensure t)  ; No need to add 'ensure t' for each package
  (setq use-package-always-defer t)  ; Defer for all package
  (setq use-package-always-demand nil) 
  (setq use-package-expand-minimally t) 
  (setq use-package-verbose t))

(use-package emacs 
  :if (display-graphic-p) 
  :config 
  (defalias 'yes-or-no-p 'y-or-n-p)
  (column-number-mode)
  (setq display-line-numbers-type 'relative) 
  (global-display-line-numbers-mode t)
  (show-paren-mode 1)
  ;; Font settings 
  (if *is-windows* 
      (progn 
        (set-face-attribute 'default nil :font "Microsoft Yahei Mono 12") 
        (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
          (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "Microsoft Yahei Mono" :size 12))))
    (if *is-mac* (set-face-attribute 'default nil :font "Monaco 12")))
  ;; Disable line numbers for some modes
  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  shell-mode-hook
                  treemacs-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))
  )

(use-package restart-emacs)

(use-package solarized-theme 
  :init (load-theme 'solarized-dark t))

(use-package smart-mode-line 
  :init 
  (setq sml/no-confirm-load-theme t) 
  (setq sml/theme 'respectful) 
  (sml/setup))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package ivy
  :defer 1
  :demand 
  :hook (after-init . ivy-mode) 
  :config 
  (ivy-mode 1) 
  (setq ivy-use-virtual-buffers t 
        ivy-initial-inputs-alist nil 
        ivy-count-format "%d/%d " 
        enable-recursive-minibuffers t 
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel 
  :after (ivy) 
  :bind (("M-x" . counsel-M-x) 
         ("C-x C-f" . counsel-find-file) 
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git))) 

(use-package swiper 
  :after ivy 
  :bind (("C-s" . swiper) 
         ("C-r" . swiper-isearch-backward)) 
  :config (setq swiper-action-recenter t 
                swiper-include-line-number-in-search t))

(use-package flycheck 
  :hook (prog-mode . flycheck-mode)) ;; You can change prog-mode to after-init for global usage

(use-package avy
  :ensure t
  :bind (("M-s" . avy-goto-word-1)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package company
  :diminish (company-mode " Cmp.")
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :hook (after-init . global-company-mode)
  :config (setq company-dabbrev-code-everywhere t
		        company-dabbrev-code-modes t
		        company-dabbrev-code-other-buffers 'all
		        company-dabbrev-downcase nil
		        company-dabbrev-ignore-case t
		        company-dabbrev-other-buffers 'all
		        company-require-match nil
		        company-minimum-prefix-length 1
		        company-show-numbers t
		        company-tooltip-limit 20
		        company-idle-delay 0
		        company-echo-delay 0
		        company-tooltip-offset-display 'scrollbar
		        company-begin-commands '(self-insert-command))
  (eval-after-load 'company
    '(add-to-list 'company-backends
                  '(company-abbrev company-yasnippet company-capf))))

(use-package lsp-mode
  ;; add prog-mode to lsp instead of adding one by one
  ;; :hook ((prog-mode . (lsp-deferred))
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (prog-mode . (lambda() (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)(lsp-deferred))))
	 (python-mode . lsp-deferred)
         )
  :init (setq lsp-keep-workspace-alive nil ;; Auto kill LSP server
              lsp-enable-indentation t
              lsp-enable-on-type-formatting t
              lsp-auto-guess-root nil
              lsp-enable-snippet t
              lsp-modeline-diagnostics-enable t
              lsp-modeline-diagnostics-scope :workspace ;; workspace/global/file
              lsp-idle-delay 0.500
              read-process-output-max (* 1024 1024) ;; 1MB
              lsp-completion-provider :capf)
  :config
  ;; Configure LSP Clients
  (use-package lsp-clients
    :ensure nil
    :functions (lsp-format-buffer lsp-organize-imports))
  commands:  (lsp lsp-deferred))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook ((lsp-mode . lsp-ui-mode)
         (lsp-ui-mode . lsp-modeline-code-actions-mode)
         ;; (lsp-ui-mode . lsp-ui-peek-mode) ;; drop it 'cause it has BUGs
         )
  :init (setq lsp-ui-doc-enable t
              lsp-ui-doc-use-webkit nil
              lsp-ui-doc-delay .3
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'at-point ;; top/bottom/at-point
              lsp-eldoc-enable-hover t ;; eldoc displays in minibuffer
              lsp-ui-sideline-enable nil
              lsp-ui-sideline-show-hover nil
              lsp-ui-sideline-show-code-actions t
              lsp-ui-sideline-show-diagnostics t
              lsp-ui-sideline-ignore-duplicate t
              lsp-modeline-code-actions-segments '(count name)
              lsp-headerline-breadcrumb-enable nil)
  :config
  (setq lsp-ui-flycheck-enable nil)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (when (display-graphic-p)
    (treemacs-resize-icons 14))
  )

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  :init
  (when (display-graphic-p)
    (treemacs-resize-icons 14)))

(use-package dap-mode
  :diminish
  :hook ((lsp-mode . dap-mode)
         (dap-mode . dap-ui-mode)
	     (dap-mode . dap-tooltip-mode)
         (python-mode . (lambda() (require 'dap-python)))
         (go-mode . (lambda() (require 'dap-go)))
         (java-mode . (lambda() (require 'dap-java)))))
