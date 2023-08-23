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

(defun my/babel-load-softly (filename)
  (condition-case err
      (org-babel-load-file filename) 
    (error (message "Error loading %s: \"%s\"" filename
                    (error-message-string err))
           nil)))


(my/load-softly "~/.emacs.d/config/core.el")
(org-babel-tangle-file "~/.emacs.d/config/package-manager.org")
(my/load-softly        "~/.emacs.d/tangled/package-manager.el")
(org-babel-tangle-file "~/.emacs.d/config/magit.org")
(my/load-softly        "~/.emacs.d/tangled/magit.el")
(org-babel-tangle-file "~/.emacs.d/config/elfeed.org")
(my/load-softly        "~/.emacs.d/tangled/elfeed.el")
(org-babel-tangle-file "~/.emacs.d/config/good-scroll.org")
(my/load-softly        "~/.emacs.d/tangled/good-scroll.el")
(org-babel-tangle-file "~/.emacs.d/config/org.org")
(my/load-softly        "~/.emacs.d/tangled/org.el")
(org-babel-tangle-file "~/.emacs.d/config/appearance.org")
(my/load-softly        "~/.emacs.d/tangled/appearance.el")

