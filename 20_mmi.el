;; MMI

;; Dark theme:
(add-to-list 'custom-theme-load-path "~/.emacs.d/thirdparty/dracula")
(load-theme 'dracula t)
(setq background-color "black")
(set-face-background 'default background-color)

;; General:
(menu-bar-mode 0)
(tool-bar-mode 0)
(savehist-mode 1)
(size-indication-mode t)
(blink-cursor-mode nil)
(column-number-mode t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq same-window-regexps '("."))
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-z") 'cua-paste) ;; like C-y, because of DE/US keyboard layouts
(put 'scroll-left 'disabled nil)

;; Column marker: 
(defun show-column-marker ()
  (interactive)
  (column-marker-1 100))
(add-hook 'c-mode-hook 'show-column-marker)
(add-hook 'c++-mode-hook 'show-column-marker)
(add-hook 'emacs-lisp-mode-hook 'show-column-marker)
(add-hook 'LaTeX-mode-hook 'show-column-marker)
(add-hook 'text-mode-hook 'show-column-marker)
(add-hook 'sh-mode-hook 'show-column-marker)
(add-hook 'python-mode-hook 'show-column-marker)
(add-hook 'js-mode-hook 'show-column-marker)

;; Font size: 
(setq my-font-size 100)
(if (display-graphic-p)
  (set-face-attribute 'default nil :height my-font-size)
)
(sleep-for 1) ;; otherwise next block might not work

;; Full screen: 
(setq mf-max-width 1900)
(setq mf-display-padding-height 50)
(maximize-frame)

;; Caps Lock inserts tab:
(if (eq window-system 'x)
    (shell-command "xmodmap -e 'clear Lock'"))
(defun insert-tab () (interactive) (insert "  ")) ;; FIXME use a constant
(global-set-key [f13] 'insert-tab)

;; Scrolling: 
(scroll-bar-mode -1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 3) ((control) . nil)))
(setq mouse-wheel-progressive-speed 't)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; Selection: 
(setq cua-enable-cua-keys nil)
(setq cua-highlight-region-shift-only t) ;; no transient mark mode
(setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(cua-mode t)

;; Highlighting:
(show-paren-mode 1)
(set-face-foreground 'minibuffer-prompt "red")
(set-face-background 'minibuffer-prompt "yellow")
(set-face-attribute 'minibuffer-prompt nil :weight 'bold)
(defun what-face (pos) ;; from http://stackoverflow.com/questions/1242352/get-font-face-under-cursor-in-emacs
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;; Invisible characters: 
(setq inhibit-eol-conversion t) ;; always show CR
(defun disable-ws ()
  (interactive)
  (global-whitespace-mode 0)
)
(if (display-graphic-p)
  (progn
    (global-whitespace-mode 1) ;; show invisible characters
    (set-face-attribute 'whitespace-space nil
                        :foreground "#404040"
                        :background background-color) ;; FIXME conflicts with the column marker
    (set-face-attribute 'whitespace-trailing nil
                        :background background-color)
  )
(disable-ws)
)
;; Trick because (global-)whitespace-newline-mode doesn't work.
;;   See http://lists.gnu.org/archive/html/bug-gnu-emacs/2011-01/msg00280.html
;;       http://www.emacswiki.org/emacs/WhiteSpace
(setq whitespace-display-mappings
  '(
    (space-mark 32 [183] [46])
    (space-mark 160 [164] [95])
    (space-mark 2208 [2212] [95])
    (space-mark 2336 [2340] [95])
    (space-mark 3616 [3620] [95])
    (space-mark 3872 [3876] [95])
    (newline-mark 10 [10])
    (tab-mark 9 [187 9] [92 9])
   ))
(setq whitespace-line-column 999) ;; don't show long lines

;; Special keys in console:
(define-key input-decode-map "\e[1;2D" [S-left])
(define-key input-decode-map "\e[1;2C" [S-right])
(define-key input-decode-map "\e[1;2A" [S-up])
(define-key input-decode-map "\e[1;2B" [S-down])
(define-key input-decode-map "\e[1;5D" [C-left])
(define-key input-decode-map "\e[1;5C" [C-right])
(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])
(define-key input-decode-map "\e[1;6D" [C-S-left])
(define-key input-decode-map "\e[1;6C" [C-S-right])
(define-key input-decode-map "\e[1;6A" [C-S-up])
(define-key input-decode-map "\e[1;6B" [C-S-down])
(unless (display-graphic-p)
  (global-set-key (kbd "<delete>") 'delete-char))

;; Debugging: 
(defun append-to-scratch (text)
  "Appends TEXT as comment at the end of the scratch."
  (interactive "s")
  (set-buffer "*scratch*")
  (end-of-buffer)
  (insert "\n;; ")
  (insert text)
  (insert "\n"))

;; Scratch: 
(setq initial-scratch-message "")
(append-to-scratch "Debugging:\n;; M-x append-to-scratch")
(append-to-scratch "Adjust font size:\n;; C-x C-+|-|0")
(append-to-scratch "Folding code:\n;; https://www.emacswiki.org/emacs/HideShow")

;; Terminal:
(add-to-list 'term-bind-key-alist '("C-z" . term-stop-subjob))
(global-set-key (kbd "C-c C-c") 'multi-term)
(setq term-unbind-key-list (delete "<ESC>" term-unbind-key-list))
(defun la-term-mode-hook ()
  "LA Term mode hook."
  )
(add-hook 'term-mode-hook 'la-term-mode-hook)
(set-face-attribute 'term nil :background background-color)
