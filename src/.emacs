(require 'package)
(require 'autorevert)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package flymake-eslint :ensure t)
(use-package wucuo :ensure t)
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

(defun setup-company ()
  (company-mode 1)
  (yas-minor-mode 1)
  (set (make-local-variable 'company-backends)
       '((company-dabbrev-code company-yasnippet))))

(defun launch-ide ()
  (auto-revert-mode +1)
  (subword-mode +1)
  (wucuo-start)
  (eglot-ensure)
  (setup-company))

(defun setup-eslint ()
  (when (or
         (eq major-mode 'js-ts-mode)
         (eq major-mode 'tsx-ts-mode)
         (eq major-mode 'typescript-ts-mode))
   (flymake-eslint-enable)))

(add-hook 'c-ts-mode-hook #'launch-ide)
(add-hook 'js-ts-mode-hook #'launch-ide)
(add-hook 'tsx-ts-mode-hook #'launch-ide)
(add-hook 'typescript-ts-mode-hook #'launch-ide)
(add-hook 'bash-ts-mode-hook #'launch-ide)
(add-hook 'eglot-managed-mode-hook #'setup-eslint)
(add-hook 'emacs-lisp-mode-hook #'setup-company)
(add-hook 'before-save-hook #'eglot-format-buffer)
(add-hook 'eglot-server-initialized-hook #'eglot-signal-didChangeConfiguration)

(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))


(yas-reload-all)
(push '(company-semantic :with company-yasnippet) company-backends)

(helm-mode +1)
(savehist-mode +1)
(desktop-save-mode +1)

(with-eval-after-load 'eglot
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
  (setq-default eglot-workspace-configuration `(:javascript ,ts-js-rules :typescript ,ts-js-rules)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-interval 1)
 '(auto-save-timeout 1)
 '(auto-save-visited-interval 1)
 '(auto-save-visited-mode t)
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 1)
 '(company-tooltip-idle-delay 0.2)
 '(company-transformers '(company-sort-by-occurrence))
 '(css-indent-offset 2)
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
 '(ispell-dictionary "en")
 '(ispell-extra-args
   '("--sug-mode=ultra" "--run-together" "--run-together-limit=16"))
 '(ispell-program-name "aspell")
 '(ispell-silently-savep t)
 '(js-indent-level 2)
 '(js-jsx-indent-level 2)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages
   '(wucuo eglot yasnippet treesit-auto markdown-mode helm-xref flymake-eslint company))
 '(standard-indent 2)
 '(treesit-font-lock-level 4))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
