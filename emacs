
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
  (global-display-line-numbers-mode t)
  ;; Font settings 
  (if *is-windows* 
      (progn 
        (set-face-attribute 'default nil :font "Microsoft Yahei Mono 12") 
        (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
          (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "Microsoft Yahei Mono" :size 12)))) 
    (set-face-attribute 'default nil :font "Monaco 12"))
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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)

  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup)) ;; Automatically installs Node debug adapter if needed

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;; (python-shell-interpreter "python3")
  ;; (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :config
  (pyvenv-mode 1))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

