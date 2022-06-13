(require 'use-package)

(use-package slime :ensure t)

(defun setup-slime-mode ()
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled idle-change))
  (eldoc-mode +1)
  (company-mode +1))

(add-hook 'slime-mode-hook #'setup-slime-mode)


