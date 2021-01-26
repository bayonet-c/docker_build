(unless (package-installed-p 'solarized-theme)
  (package-install 'solarized-theme))
(use-package solarized-theme 
  :init (load-theme 'solarized-dark t))

(use-package smart-mode-line 
    :init 
    (setq sml/no-confirm-load-theme t) 
    (setq sml/theme 'respectful) 
    (sml/setup))

(use-package emacs 
  :if (display-graphic-p) 
  :config 
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq display-line-numbers-type 'relative) 
  (global-display-line-numbers-mode t)
  ;; Font settings 
  (if *is-windows* 
    (progn 
      (set-face-attribute 'default nil :font "Microsoft Yahei Mono 12") 
      (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
        (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "Microsoft Yahei Mono" :size 12)))) 
    (set-face-attribute 'default nil :font "Monaco 12")))

(provide 'init-ui)
