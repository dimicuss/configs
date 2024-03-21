(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package flymake-eslint :ensure t)
(use-package markdown-mode :ensure t)
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
  (yas-minor-mode 1)
  (set (make-local-variable 'company-backends)
       '((company-dabbrev-code company-yasnippet))))

(defun launch-ide ()
  (eglot-ensure)
  (eglot-signal-didChangeConfiguration (eglot--current-server-or-lose))
  (setup-company))

(defun launch-typescript-ide ()
  (setq ts-js-rules '(:format (:indentSize 2
                               :convertTabsToSpaces t
                               :tabSize  2
                               :insertSpaceAfterConstructor nil
                               :insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces nil
                               :insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets nil
                               :insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis nil
                               :insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces nil
                               :insertSpaceBeforeFunctionParenthesis nil
                               :insertSpaceBeforeTypeAnnotation nil)))
  
  (setq base-dir (locate-dominating-file (buffer-file-name) "tsconfig.json"))
  (setq-default eglot-workspace-configuration `(:javascript ,ts-js-rules :typescript ,ts-js-rules))
  (setq-local flymake-eslint-project-root base-dir)
  
  (add-hook 'eglot-managed-mode-hook #'flymake-eslint-enable)
  (eglot-ensure)
  (eglot-signal-didChangeConfiguration (eglot--current-server-or-lose))
  (setup-company))

(add-hook 'js-ts-mode-hook #'launch-typescript-ide)
(add-hook 'tsx-ts-mode-hook #'launch-typescript-ide)
(add-hook 'typescript-ts-mode-hook #'launch-typescript-ide)
(add-hook 'bash-ts-mode-hook #'launch-ide)
(add-hook 'emacs-lisp-mode-hook #'setup-company)
(add-hook 'before-save-hook #'eglot-format-buffer)

(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(yas-reload-all)
(push '(company-semantic :with company-yasnippet) company-backends)

(helm-mode 1)
(savehist-mode 1)
(tab-bar-mode 1)
(desktop-save-mode 1)

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
 '(display-line-numbers t)
 '(eglot-autoshutdown t)
 '(eglot-send-changes-idle-time 0.2)
 '(flymake-eslint-prefer-json-diagnostics nil)
 '(helm-xref-candidate-formatting-function 'helm-xref-format-candidate-full-path)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary nil)
 '(js-indent-level 2)
 '(js-jsx-indent-level 2)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages nil)
 '(standard-indent 2)
 '(treesit-font-lock-level 4))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
