(require 'package)
(require 'autorevert)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package markdown-mode :ensure t)
(use-package helm :ensure t)
(use-package helm-xref :ensure t)
(use-package yasnippet :ensure t)
(use-package company :ensure t)
(use-package lsp-mode :ensure t)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package web-mode
  :ensure t
  :mode
  (("\\.html\\'" . web-mode)
   ("\\.phtml\\'" . web-mode)
   ("\\.php\\'" . web-mode)
   ("\\.tpl\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)))

(defun setup-company ()
  (company-mode 1)
  (yas-minor-mode 1)
  (set (make-local-variable 'company-backends)
       '((company-dabbrev-code company-yasnippet))))

(defun launch-ide ()
  (flyspell-mode +1)
  (auto-revert-mode +1)
  (subword-mode +1)
  (lsp-mode +1)
  (setup-company))

(add-hook 'css-ts-mode-hook #'launch-ide)
(add-hook 'scss-mode-hook #'launch-ide)
(add-hook 'c-ts-mode-hook #'launch-ide)
(add-hook 'js-ts-mode-hook #'launch-ide)
(add-hook 'tsx-ts-mode-hook #'launch-ide)
(add-hook 'typescript-ts-mode-hook #'launch-ide)
(add-hook 'bash-ts-mode-hook #'launch-ide)
(add-hook 'emacs-lisp-mode-hook #'setup-company)
(add-hook 'before-save-hook #'lsp-format-buffer)

(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-ts-mode))


(yas-reload-all)
(push '(company-semantic :with company-yasnippet) company-backends)

(helm-mode +1)
(savehist-mode +1)
(desktop-save-mode +1)
(electric-indent-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-visited-interval 3)
 '(auto-save-visited-mode t)
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 1)
 '(company-tooltip-idle-delay 0.2)
 '(company-transformers '(company-sort-by-backend-importance))
 '(completion-styles '(basic partial-completion substring))
 '(completions-sort 'historical)
 '(css-indent-offset 2)
 '(custom-enabled-themes '(modus-vivendi))
 '(desktop-save-mode t)
 '(display-line-numbers t)
 '(helm-xref-candidate-formatting-function 'helm-xref-format-candidate-full-path)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary "en")
 '(ispell-extra-args
   '("--sug-mode=ultra" "--run-together" "--run-together-limit=16"
     "--camel-case"))
 '(ispell-program-name "aspell")
 '(ispell-silently-savep t)
 '(js-indent-level 2)
 '(js-jsx-indent-level 2)
 '(lsp-eslint-auto-fix-on-save nil)
 '(lsp-eslint-run "onSave")
 '(lsp-javascript-format-insert-space-after-opening-and-before-closing-nonempty-braces nil)
 '(lsp-typescript-format-insert-space-after-opening-and-before-closing-nonempty-braces nil)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages nil)
 '(standard-indent 2)
 '(treesit-font-lock-level 4)
 '(web-mode-enable-auto-pairing t)
 '(web-mode-enable-current-column-highlight t)
 '(web-mode-enable-current-element-highlight t))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
