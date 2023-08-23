(defun my/load-softly (filename)
  "As `require', but instead of an error just print a message.

If there is an error, its message will be included in the message
printed.

Like `require', the return value will be FEATURE if the load was
successful (or unnecessary) and nil if not."
  (condition-case err
      (load filename) 
    (error (message "Error loading %s: \"%s\"" filename
                    (error-message-string err))
           nil)))

(my/load-softly "~/.emacs.d/config/core.el")
(org-babel-tangle-file "~/.emacs.d/config/modules.org")
(my/load-softly        "~/.emacs.d/tangled/modules.el")
