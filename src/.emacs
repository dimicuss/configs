(require 'package)
(require 'autorevert)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package helm :ensure t)
(use-package markdown-mode :ensure t)
(use-package lsp-mode :ensure t)
(use-package lsp-ui :ensure t)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

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

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn    
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(defun launch-ide ()
  (flyspell-mode +1)
  (subword-mode +1)
  (lsp-mode +1))

(helm-mode +1)
(auto-revert-mode +1)
(savehist-mode +1)
(desktop-save-mode +1)
(electric-indent-mode -1)
(treemacs-start-on-boot)

(add-hook 'css-ts-mode-hook #'launch-ide)
(add-hook 'scss-mode-hook #'launch-ide)
(add-hook 'c-ts-mode-hook #'launch-ide)
(add-hook 'js-ts-mode-hook #'launch-ide)
(add-hook 'tsx-ts-mode-hook #'launch-ide)
(add-hook 'typescript-ts-mode-hook #'launch-ide)
(add-hook 'bash-ts-mode-hook #'launch-ide)
(add-hook 'before-save-hook #'lsp-format-buffer)

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-ts-mode))

(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(define-key global-map [remap xref-find-references] #'lsp-find-references)

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
 '(lsp-eldoc-render-all t)
 '(lsp-eslint-auto-fix-on-save t)
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
