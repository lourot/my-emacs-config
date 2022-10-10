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
(setq ring-bell-function 'ignore)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-z") 'cua-paste) ;; like C-y, because of DE/US keyboard layouts
(put 'scroll-left 'disabled nil)

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
                        :foreground "#606060"
                        :background background-color)
    (set-face-attribute 'whitespace-trailing nil
                        :background background-color)
    (set-face-attribute 'whitespace-empty nil
                        :background "#606060")
  )
(disable-ws)
)

;; Column marker:
;; See
;; - https://www.emacswiki.org/emacs/EightyColumnRule
;; - https://www.emacswiki.org/emacs/WhiteSpace#toc7
;; - https://stackoverflow.com/a/7955221/1855917
(setq whitespace-style
      '(face spaces tabs newline space-mark tab-mark trailing lines-tail empty))
(setq whitespace-line-column 79)

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
(append-to-scratch "Show line numbers for current buffer:\n;; M-x linum-mode")
(append-to-scratch "Folding code:\n;; https://www.emacswiki.org/emacs/HideShow")

;; Terminal:
(setq key-open-vterm (kbd "C-c C-c"))
(global-set-key key-open-vterm 'multi-vterm)

;; Font size:
(defun la-set-font (height)
  (interactive)
  (if (display-graphic-p)
    (progn
      ;; See https://www.emacswiki.org/emacs/SetFonts :
      (set-face-attribute 'default nil :font "Noto Mono")
      (set-face-attribute 'default nil :height height)

      ;; See https://ianyepan.github.io/posts/emacs-emojis/ :
      (set-fontset-font t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend)
    )
  )
)
(defun la-set-font-xlarge ()
  (interactive)
  (la-set-font 140)
)
(defun la-set-font-large ()
  (interactive)
  (la-set-font 120)
)
(defun la-set-font-medium ()
  (interactive)
  (la-set-font 100)
)
(defun la-set-font-small ()
  (interactive)
  (la-set-font 90)
)
(defun la-set-font-xsmall ()
  (interactive)
  (la-set-font 75)
)
(run-with-idle-timer 4 nil 'la-set-font-small)

;; Splitting screen:
(defun la-split-window-six ()
  (interactive)
  (delete-other-windows)
  (split-window-vertically)
  (split-window-horizontally)
  (split-window-horizontally)
  (other-window 3)
  (split-window-horizontally)
  (split-window-horizontally)
  (other-window 3)
  (balance-windows)
)
