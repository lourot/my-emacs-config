;; Modules:
(server-start)
(add-to-list 'load-path "~/.emacs.d/thirdparty/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/autocompletepopup/")
(load "buff-menu")
(require 'revbufs)
(require 'grep-edit)
(require 'multi-term)

;; Fix auto-complete popups by using `pos-tip.el` instead of `popup.el`, see
;; https://github.com/auto-complete/auto-complete/issues/402#issuecomment-105750453
(require 'pos-tip)
(require 'auto-complete-config)

(require 'maxframe)
(require 'ansi-color) ;; for colorize-compilation-buffer
(require 'yaml-mode)
(require 'json-mode)

(add-to-list 'load-path "~/.emacs.d/thirdparty/js2-mode-20180331.2247/")
(require 'js2-mode)

;; We need at least Emacs 24.4, see https://github.com/jorgenschaefer/elpy/issues/1431
(when (or (> emacs-major-version 24)
          (and (= emacs-major-version 24) (> emacs-minor-version 3)))
  ;; See https://melpa.org/#/getting-started
  (require 'package)
  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (package-initialize)
  (package-install 'elpy)
  (elpy-enable)

  (package-install 'ggtags)
)

(add-to-list 'load-path "~/.emacs.d/thirdparty/floobits/")
(load "floobits")

;; Subconfs:
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "05_core")
(load "10_filehandling")
(load "20_mmi")
(load "30_editing")
(load "50_projects")

;; Generated:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-name-width 30)
 '(package-selected-packages '(ggtags elpy))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
