(use-package typescript-mode :ensure t)
(use-package company :ensure t)
(add-hook 'typescript-mode-hook 'lsp-deferred)
(add-hook 'typescript-mode-hook (lambda () (company-mode +1)))
					     

