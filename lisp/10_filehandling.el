;; FILE HANDLING 

;; General: 
(setq make-backup-files nil)
(desktop-save-mode 1)
(setq desktop-path '("~/.emacs.d/desktop/"))
(setq desktop-dirname "~/.emacs.d/desktop/")
(setq desktop-base-file-name "emacs-desktop")

;; Automatic buffer revertion: 
;; Note: (global-auto-revert-mode) doesn't fit our needs because during a git
;;       rebase, emacs may start to revert all the buffers, leading either to
;;       a failure of the rebase or a crash of emacs. 
;;       The following solution prevents revertion while an instance of git is
;;       running. 
(global-auto-revert-mode 0)
(defun la-revert ()
  (interactive)
  (if (= (call-process "~/.emacs.d/bin/gitrunning.sh" nil nil t) 0)
      (revbufs)
      (la-short-message "Git running, delaying revert...")
  ))
(run-with-timer 0 5 'la-revert)

;; Closing orphans: 
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(defun la-close-orphans ()
  (interactive)
  (dolist (buf (buffer-list))
    (setq to-be-killed nil)
    (setq fname (buffer-file-name buf))
    (if fname
      (if (not (file-exists-p fname))
        (setq to-be-killed t)
      )
    )
    (if to-be-killed
      (kill-buffer buf)
    )
  )
)
(global-set-key (kbd "C-k") 'la-close-orphans)

;; Directory listing: 
(setq dired-listing-switches "--group-directories-first -l -h")
(add-hook 'dired-mode-hook (lambda () (setq truncate-lines t)))
;; use wdired-change-to-wdired-mode
