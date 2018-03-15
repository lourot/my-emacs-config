;; Modules: 
(server-start)
(add-to-list 'load-path "~/.emacs.d/thirdparty/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/thirdparty/cedet-1.1/common")
(load "buff-menu_23") ;; buff-menu+ doesn't support buff-menu_24
(require 'buff-menu+)
(require 'revbufs)
(require 'grep-edit)
(add-to-list 'load-path "~/.emacs.d/thirdparty/crouton-emacs-conf/thirdparty/")
(require 'multi-term)

(require 'auto-complete-config)
(require 'maxframe)
(require 'ansi-color) ;; for colorize-compilation-buffer

;; Subconf: 
(add-to-list 'load-path "~/.emacs.d/")
(load "05_core")
(load "10_filehandling")
(load "20_mmi")
(load "30_editing")
(load "40_building")
(add-to-list 'load-path "~/.emacs.d/thirdparty/crouton-emacs-conf/")
(load "crouton-emacs-conf")
