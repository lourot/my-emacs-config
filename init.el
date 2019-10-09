;; Modules:
(server-start)
(add-to-list 'load-path "~/.emacs.d/thirdparty/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/autocompletepopup/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/cedet-1.1/common")
(load "buff-menu_23") ;; buff-menu+ doesn't support buff-menu_24
(require 'buff-menu+)
(require 'revbufs)
(require 'grep-edit)
(add-to-list 'load-path "~/.emacs.d/thirdparty/crouton-emacs-conf/thirdparty/")
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

;; See https://elpy.readthedocs.io/en/latest/introduction.html#manually-from-sources
(add-to-list 'load-path "~/.emacs.d/thirdparty/elpy/")

;; We need at least Emacs 24.4, see https://github.com/jorgenschaefer/elpy/issues/1431
(when (or (> emacs-major-version 24)
          (and (= emacs-major-version 24) (> emacs-minor-version 3)))
  (load "elpy")
  (load "elpy-rpc")
  (load "elpy-shell")
  (load "elpy-profile")
  (load "elpy-refactor")
  (load "elpy-django")
)

;; Subconfs:
(add-to-list 'load-path "~/.emacs.d/")
(load "05_core")
(load "10_filehandling")
(load "20_mmi")
(load "30_editing")
(load "40_building")
(load "50_projects")
(add-to-list 'load-path "~/.emacs.d/thirdparty/crouton-emacs-conf/")
(load "crouton-emacs-conf")
