(defvar help-bar-commands-to-learn
  (list (list "C-c C-n"
	      "query-replace-highlighted")))


(defun help-bar-text-content ()
  (mapconcat (lambda (key)
	       (concat (car key) "\n" (cadr key)))
	   help-bar-commands-to-learn
	   "\n"))

(defface help-bar-sidebar-keycommand-face
  '((t (:background "#f0f0f0")))
  "Face for help bar keysequnces")

(defface help-bar-sidebar-command-face
  '((t (:background "#00ffaa")))
  "Face for help bar commands that are the actual results")

(defun help-bar-sidebar-toggle ()
  "Toggle the sidebar window displaying the *my-sidebar* buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*test*"))
	(content (help-bar-text-content)))
    ;; Check if the sidebar window is already open
    (if-let ((window (get-buffer-window buffer)))
        ;; If the window exists, close it
        (delete-window window)
      ;; Otherwise, display the sidebar using the standard display-buffer-in-side-window
      (display-buffer-in-side-window
       buffer '((side . left)
                (slot . 0)
                (window-width . 30)
                (window-parameters . ((no-other-window . t)
                                      (no-delete-other-windows . t)))))
      ;; Populate the sidebar buffer content (optional)
      (with-current-buffer buffer
        (erase-buffer)
	(mapc
	 (lambda (command)
	   (insert (car command))
	   (insert "\n")
	   (font-lock-add-keywords nil
				   `((,(car command) . font-lock-keyword-face)))
	   (insert (cadr command))
	   (insert "\n"))
	 help-bar-commands-to-learn)))))

;; certain fonts only have a meaning in certain modes
;; so now you need to make sure that the faces are enabled
;; for whatever mode the help buffer is in?
;; do you _want_ to right a major mode for the help buffer?
;; I'm not sure
 ;; Return t to signal a match
(global-set-key (kbd "C-h C-l") 'help-bar-sidebar-toggle)



(font-lock-add-keywords 'lisp-interaction-mode
			'(("foo" . font-lock-keyword-face)))



