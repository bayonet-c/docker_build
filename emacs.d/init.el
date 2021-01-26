
(add-to-list 'load-path
      (expand-file-name (concat user-emacs-directory "customize")))
(setq custom-file 
      (expand-file-name "custom.el" user-emacs-directory))

(require 'init-const)
(require 'init-startup)
(require 'init-elpa)
(require 'init-ui)
(require 'init-package)

(when (file-exists-p custom-file)
  (load-file custom-file))
