(defvar help-bar-commands-to-learn
  (list (list "C-c C-n"
	      "query-replace-highlighted")))


(defun help-bar-text-content ()
  (mapconcat (lambda (key)
	       (concat (car key) "\n" (cadr key)))
	   help-bar-commands-to-learn
	   "\n"))

(defface help-bar-sidebar-keycommand-face
  '((t :foreground "SeaGreen3"
       :inherit default))
  "Face for help bar keysequnces")

(defface help-bar-sidebar-command-face
  '((t :inherit default :foreground "light goldenrod" :height 1.5))
  "Face for help bar commands that are the actual results")

(defun help-bar-sidebar-toggle ()
  "Toggle the sidebar window displaying the *my-sidebar* buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*test*"))
	(content (help-bar-text-content)))
    (if-let ((window (get-buffer-window buffer)))
        (delete-window window)
      (display-buffer-in-side-window
       buffer '((side . left)
                (slot . 0)
                (window-width . 30)
                (window-parameters . ((no-other-window . t)
                                      (no-delete-other-windows . t)))))
      (with-current-buffer buffer
        (erase-buffer)
	(mapc
	 (lambda (command)
	   (font-lock-add-keywords nil
				   `((,(car command) . 'help-bar-sidebar-keycommand-face))
				   'append)
	   (font-lock-add-keywords nil
				   `((,(cadr command) . 'help-bar-sidebar-command-face))
				   'append)
	   (insert (car command))
	   (insert "\n")
	   (insert (cadr command))
	   (insert "\n"))
	 help-bar-commands-to-learn)
	(font-lock-fontify-buffer)))))


(global-set-key (kbd "C-h C-l") 'help-bar-sidebar-toggle)


(provide 'help-sidebar)
