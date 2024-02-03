(require 'package)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package quelpa-use-package :ensure t)
(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs :ensure t :after tree-sitter)
(use-package lsp-mode :ensure t)


(load "~/.emacs.d/config/typescript.el")
(load "~/.emacs.d/config/lisp.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(custom-enabled-themes '(deeper-blue))
 '(indent-tabs-mode nil)
 '(inferior-lisp-program "sbcl" t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary nil)
 '(js-indent-level 2)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages
   '(tsi quelpa-use-package tree-sitter tree-sitter-langs tiny slime web-mode use-package tide company))
 '(typescript-indent-level 2)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
