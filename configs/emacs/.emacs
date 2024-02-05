(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package lsp-mode :ensure t)
(use-package company :ensure t)
(use-package yasnippet :ensure t)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(add-to-list 'treesit-auto-recipe-list (make-treesit-auto-recipe
	:lang 'tsx
	:ts-mode 'tsx-ts-mode
	:remap '(typescript-tsx-mode)
	:requires 'typescript
	:url "https://github.com/tree-sitter/tree-sitter-typescript"
	:revision "v0.20.2"
	:source-dir "tsx/src"
	:ext "\\.tsx\\'"))

(add-to-list 'treesit-auto-recipe-list (make-treesit-auto-recipe
	:lang 'typescript	       
	:ts-mode 'typescript-ts-mode
	:remap 'typescript-mode
	:requires 'tsx
	:url "https://github.com/tree-sitter/tree-sitter-typescript"
	:revision "v0.20.2"
	:source-dir "typescript/src"
	:ext "\\.ts\\'"))

(defun handle-ts-mode ()
  (company-mode +1)
  (yas-minor-mode)
  (lsp-deferred))

(add-hook 'tsx-ts-mode-hook #'handle-ts-mode)
(add-hook 'typescript-ts-mode-hook #'handle-ts-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary nil)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages nil)
 '(treesit-font-lock-level 4)
 '(warning-minimum-level :error))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
