;; BUILDING

;; General: 
(defun la-compile ()
  (interactive)
  (call-interactively 'compile)
  (switch-to-buffer "*compilation*")
  (end-of-buffer)
)
(global-set-key (kbd "C-c b") 'la-compile)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(setq compile-command "./build.sh")
