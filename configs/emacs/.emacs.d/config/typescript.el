(require 'use-package)

(use-package web-mode :ensure t)
(use-package company :ensure t)
(use-package tide :ensure t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (eldoc-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(defun setup-tsx ()
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (setup-tide-mode)))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'web-mode-hook #'setup-tsx)
