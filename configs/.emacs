(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package helm :ensure t)
(use-package helm-xref :ensure t)
(use-package yasnippet :ensure t)
(use-package company :ensure t)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(add-to-list 'treesit-auto-recipe-list
             (make-treesit-auto-recipe
	      :lang 'tsx
	      :ts-mode 'tsx-ts-mode
	      :remap '(typescript-tsx-mode)
	      :requires 'typescript
	      :url "https://github.com/tree-sitter/tree-sitter-typescript"
	      :revision "v0.20.3"
	      :source-dir "tsx/src"
	      :ext "\\.tsx\\'"))

(add-to-list 'treesit-auto-recipe-list
             (make-treesit-auto-recipe
	      :lang 'typescript	       
	      :ts-mode 'typescript-ts-mode
	      :remap 'typescript-mode
	      :requires 'tsx
	      :url "https://github.com/tree-sitter/tree-sitter-typescript"
	      :revision "v0.20.3"
	      :source-dir "typescript/src"
	      :ext "\\.ts\\'"))

(defun setup-company ()
  (company-mode 1)
  (yas-minor-mode)
  (set (make-local-variable 'company-backends)
       '((company-dabbrev-code company-yasnippet))))

(defun handle-ts-mode ()
  (eglot-ensure)
  (setup-company))

(add-hook 'tsx-ts-mode-hook #'handle-ts-mode)
(add-hook 'typescript-ts-mode-hook #'handle-ts-mode)
(add-hook 'bash-ts-mode-hook #'handle-ts-mode)
(add-hook 'emacs-lisp-mode-hook #'setup-company)
(add-hook 'before-save-hook #'eglot-format-buffer)

(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(helm-mode 1)
(yas-reload-all)
(savehist-mode 1)
(desktop-save-mode 1)
(push '(company-semantic :with company-yasnippet) company-backends)

(setq read-process-output-max (* 1024 1024))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 1)
 '(company-tooltip-idle-delay 0.2)
 '(custom-enabled-themes '(wombat))
 '(desktop-save-mode t)
 '(gc-cons-threshold 1600000)
 '(helm-xref-candidate-formatting-function 'helm-xref-format-candidate-full-path)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary nil)
 '(js-indent-level 2)
 '(js-jsx-indent-level 2)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages
   '(yasnippet treesit-auto pkg-info langtool helm-xref company))
 '(standard-indent 2)
 '(treesit-font-lock-level 4))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
