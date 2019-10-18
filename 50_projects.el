;; PROJECT-SPECIFIC

(setq esys-tabwidth 8)

(defun esys-sh-mode ()
  "ESYS SH mode"
  (interactive)
  (sh-mode)
  (setq sh-basic-offset esys-tabwidth)
  (setq indent-tabs-mode t) ;; indent with TAB instead of blanks
  (setq mode-name "ESYS SH") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("/esys/.*\\.sh\\'" . esys-sh-mode)) ;;FIXME doesn't work

;; Scratch:
(append-to-scratch "Join an existing floobits workspace:\n;; M-x floobits-join-workspace <RET> https://floobits.com/AurelienLourot/test <RET>")
