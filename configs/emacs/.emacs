(eval-when-compile
  (require 'package)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (package-initialize))

(load "~/.emacs.d/config/lisp.el")
(load "~/.emacs.d/config/typescript.el")
(global-set-key (kbd "C-x C-c") nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(auto-save-default nil)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(custom-enabled-themes '(tango-dark))
 '(flycheck-idle-change-delay 0.1)
 '(indent-tabs-mode nil)
 '(inferior-lisp-program "sbcl" t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-dictionary nil)
 '(js-indent-level 2)
 '(make-backup-files nil)
 '(message-log-max nil)
 '(package-selected-packages '(tiny slime web-mode use-package tide company))
 '(tide-format-options
   '(indentSize 2 tabSize 2 insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces nil))
 '(typescript-indent-level 2)
 '(web-mode-auto-close-style 2)
 '(web-mode-auto-quote-style 3)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-enable-auto-indentation nil)
 '(web-mode-enable-auto-quoting t)
 '(web-mode-indent-style 1)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-tests-directory "~/tests/"))



