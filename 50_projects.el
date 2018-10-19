;; PROJECT-SPECIFIC

(setq esys-tabwidth 8)

(defun esys-python-mode ()
  "ESYS Python mode"
  (python-mode)
  (setq tab-width esys-tabwidth) ;; display width of character TAB
  (setq indent-tabs-mode t) ;; indent with TAB instead of blanks
  (setq mode-name "ESYS Python") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("/esys/.*\\.py\\'" . esys-python-mode))

(defun esys-conf-mode ()
  "ESYS Conf mode"
  (conf-colon-mode)
  (setq tab-width esys-tabwidth) ;; display width of character TAB
  (setq indent-tabs-mode t) ;; indent with TAB instead of blanks
  (setq mode-name "ESYS Conf") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("/esys/.*\\.conf\\'" . esys-conf-mode))

(defun esys-sql-mode ()
  "ESYS SQL mode"
  (sql-mode)
  (setq tab-width esys-tabwidth) ;; display width of character TAB
  (setq indent-tabs-mode t) ;; indent with TAB instead of blanks
  (setq mode-name "ESYS SQL") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("/esys/.*\\.sql\\'" . esys-sql-mode))

(defun esys-sh-mode ()
  "ESYS SH mode"
  (interactive)
  (sh-mode)
  (setq sh-basic-offset esys-tabwidth)
  (setq indent-tabs-mode t) ;; indent with TAB instead of blanks
  (setq mode-name "ESYS SH") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("/esys/.*\\.sh\\'" . esys-sh-mode)) ;;FIXME doesn't work
