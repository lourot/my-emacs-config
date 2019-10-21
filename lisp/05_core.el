;; CORE 

;; Short-time message: 
(setq erase-message 0)
(defun message-eraser ()
  (interactive)
  (if (> erase-message 0)
    (progn
      (if (> erase-message 1)
        (progn
          (setq erase-message 0)
          (message nil) ;; erases message
        )
        (setq erase-message (1+ erase-message))
      )
    )
  )
)
(run-with-timer 0 1 'message-eraser)
(defun la-short-message (text)
  "Writes message to minibuffers that will be erased about one second later."
  (interactive "s")
  (message text)
  (setq erase-message 1)
)
