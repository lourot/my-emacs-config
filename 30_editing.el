;; EDITING

;; General:
(delete-selection-mode t)
(setq-default indent-tabs-mode nil)

;; Auto-completion:
(add-to-list 'ac-dictionary-directories "~/.emacs.d/thirdparty/autocomplete/dict")
(ac-config-default)

;; Fix broken popup, see https://stackoverflow.com/a/13242340/1855917
(setq popup-use-optimized-column-computation nil)

;; De-indentation:
(setq la-tabwidth 2)
(setq la-tabwidth-java (* 2 la-tabwidth))
(defun deindent ()
  (interactive)
  (setq blanks-to-remove la-tabwidth)
  (setq continue t)
  (setq consecutive-blanks 0)
  (while continue
    (goto-char (1- (point))) ;; go back of one character
    (if (= (char-after) 32) 
        (setq consecutive-blanks (1+ consecutive-blanks))
        (setq consecutive-blanks 0))
    (if (= consecutive-blanks blanks-to-remove)
        (progn
          (delete-char blanks-to-remove)
          (setq continue nil)))
    (if (= (point) (point-at-bol))
        (setq continue nil))
  )
)
(global-set-key [backtab] 'deindent)

;; Line Commenting:
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-x C-h") 'toggle-comment-on-line)

;; Word highlighting:
(defface la-highlight-face
  '((((class color) (background light))
     (:inherit 'font-lock-comment-face :foreground "red" :background "yellow" :weight bold))
    (((class color) (background dark))
     (:inherit 'font-lock-comment-face :foreground "red" :background "yellow" :weight bold))
    (t (:bold t :italic t)))
  "LA highlight face"
  :group 'font-lock-highlighting-faces)
(defvar la-highlight-keywords
  '(
    ("\\<\\(LA_\\w*\\>\\)" 1 'la-highlight-face prepend)
    ("\\<\\(FIXME\\>\\)" 1 'la-highlight-face prepend)
    ("\\<\\(TODO\\>\\)" 1 'la-highlight-face prepend)
    ("\\<\\(XXX\\>\\)" 1 'la-highlight-face prepend)
   ))
(defun set-la-highlight ()
  (interactive)
  (font-lock-add-keywords nil la-highlight-keywords))

;; C/C++:
;; we don't set c-syntactic-indentation to nil as it would disable smart indentation
(defun la-cpp-mode ()
  "LA C++ mode"
  (c++-mode)
  (c-set-style "K&R")
  (setq c-basic-offset la-tabwidth)
  (c-set-offset 'case-label '+)
  ;; (c-set-offset 'access-label '/) ;; half tab to left
  (c-set-offset 'inclass '+)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'statement-cont '++)
  (c-set-offset 'innamespace '0) ;; don't indent namespace content
  (setq tab-width la-tabwidth) ;; display width of character TAB
  (add-to-list 'c-cleanup-list 'comment-close-slash)
  (setq mode-name "LA C++") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.[ch]p?p?\\'" . la-cpp-mode))

;; C/C++ (various shortcuts and disable auto-indent):
(defun la-cpp-mode-hook ()
  "LA C++ mode hook."
  (local-set-key  (kbd "C-c C-c") nil)
  (local-set-key  (kbd "C-c o") 'ff-find-other-file)
  ;; (local-set-key (kbd "<C-tab>") 'semantic-complete-analyze-inline)
  ;; (local-set-key (kbd "<C-S-iso-lefttab>") 'semantic-ia-complete-symbol)
  (local-set-key (kbd "M-1") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-M-1") 'semantic-ia-fast-jump-back)
  (local-set-key (kbd "M-2") 'semantic-symref)
  (local-set-key (kbd "M-3") 'semantic-symref-symbol)
  (local-set-key (kbd "M-4") 'semantic-analyze-proto-impl-toggle)
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
  (local-set-key (kbd ";") 'self-insert-command)
  (local-set-key (kbd ",") 'self-insert-command)
  (local-set-key (kbd "*") 'self-insert-command)
  (local-set-key (kbd ":") 'self-insert-command)
  ;; (local-set-key (kbd "/") 'self-insert-command)
  (local-set-key (kbd "(") 'self-insert-command)
  (local-set-key (kbd ")") 'self-insert-command)
  (local-set-key (kbd "{") 'self-insert-command)
  (local-set-key (kbd "}") 'self-insert-command))
(add-hook 'c++-mode-hook 'la-cpp-mode-hook)

;;FIXME some statements are duplicated across programming languages, like
;; (local-set-key (kbd ")") 'self-insert-command)

;; C/C++ (word highlighting):
(add-hook 'c-mode-common-hook 'set-la-highlight)

;; C/C++ (auto-completion):
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-abbrev-table 'c++-mode-abbrev-table ())
;; (define-abbrev c++-mode-abbrev-table "include" "" 'la-include)
(define-skeleton la-include
  "Insert include"
  ""
  "#include " ?" _ ?"
)
(unless (featurep 'cedet)
  (load "cedet") ;; must be before any other CEDET stuff
)
(global-ede-mode 1)
(require 'eieio-opt)
(unless (string= cedet-version "1.0")
  (progn
    (semantic-load-enable-code-helpers)
    (semantic-debug-idle-work-function)))
(global-semantic-highlight-func-mode 1)
(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
      (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
         (alist (semantic-mrub-ring-to-assoc-list ring))
         (first (cdr (car alist))))
    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
          (setq first (cdr (car (cdr alist)))))
    (semantic-mrub-switch-tags first)))

;; Python:
;; Disables CEDET as it leads to freezes. See https://github.com/jorgenschaefer/elpy/issues/226
(remove-hook 'python-mode-hook 'wisent-python-default-setup)

;; LaTeX:
(setq font-latex-fontify-sectioning 'color) ;; disable different font sizes

;; Lisp:
(defun la-lisp-mode ()
  "LA Lisp mode"
  (emacs-lisp-mode)
  (setq mode-name "LA Lisp") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.el\\'" . la-lisp-mode))

;; Lisp (word highlighting):
(font-lock-add-keywords 'emacs-lisp-mode la-highlight-keywords)

;; Text:
(defun la-text-mode ()
  "LA Text mode"
  (text-mode)
  (setq mode-name "LA Text") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . la-text-mode))
(custom-set-variables
    '(tab-stop-list (quote (  4   8  12  16  20  24  28  32  36  40
                             44  48  52  56  60  64  68  72  76  80 
                             84  88  92  96 100 104 108 112 116 120))))

;; Javascript:
(defun la-js-mode ()
  "LA JS mode"
  (js-mode)
  (setq js-indent-level 2)
  (setq mode-name "LA JS") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.js\\'" . la-js-mode))

;; Javascript (disable auto-indent):
(defun la-js-mode-hook ()
  "LA JS mode hook."
  (local-set-key (kbd ";") 'self-insert-command)
)
(add-hook 'js-mode-hook 'la-js-mode-hook)

;; CSS:
(defun la-css-mode ()
  "LA CSS mode"
  (css-mode)
  (setq css-indent-offset 2)
  (setq mode-name "LA CSS") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.css\\'" . la-css-mode))

;; Java:
(defun la-java-mode ()
  "LA Java mode"
  (java-mode)
  (c-set-style "java")
  (setq c-basic-offset la-tabwidth-java)
  (setq tab-width la-tabwidth-java) ;; display width of character TAB
  (c-set-offset 'arglist-intro '++)         ;; argument indentation
  (c-set-offset 'arglist-cont-nonempty '++) ;; argument indentation
  (setq mode-name "LA Java") ;; must be the last one
)
(add-to-list 'auto-mode-alist '("\\.java\\'" . la-java-mode))

;; Java (disable auto-indent):
(defun la-java-mode-hook ()
  "LA Java mode hook."
  (local-set-key (kbd ")") 'self-insert-command)
  (local-set-key (kbd "(") 'self-insert-command)
  (local-set-key (kbd "/") 'self-insert-command)
)
(add-hook 'java-mode-hook 'la-java-mode-hook)

;; YAML:
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; YAML (word highlighting):
(add-hook 'yaml-mode-hook 'set-la-highlight)

;; Term (paste):
(defun la-term-mode-hook ()
  "LA Term mode hook."
  (local-set-key  (kbd "C-y") 'term-paste) ;; can be done with S-insert too
)
(add-hook 'term-mode-hook 'la-term-mode-hook)

;; Finding files:
(defun la-save-grep-changes ()
  (interactive)
  (grep-edit-finish-edit)
  (save-some-buffers)
)
(defun la-grep-mode-hook ()
  "LA Grep mode hook."
  (local-set-key  (kbd "C-x C-s") 'la-save-grep-changes)
)
(add-hook 'grep-mode-hook 'la-grep-mode-hook)
(setq grep-use-null-device t) ;; skips grep-probe, which would make the first grep very slow
(setq grep-command "rgrep --exclude-dir=\".git\" --exclude-dir=\"thirdparty\" -n LA_ *")

;; Macro replay:
(global-set-key (kbd "C-#") 'kmacro-end-and-call-macro)
