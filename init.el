(defun my/load-softly (filename)
  "As `require', but instead of an error just print a message.

If there is an error, its message will be included in the message
printed.

Like `require', the return value will be FEATURE if the load was
successful (or unnecessary) and nil if not."
  (condition-case err
      (load filename) 
    (error (message "Error loading %s: \"%s\""
                    (if filename (format "%s (%s)" "TEST" filename) "TEST")
                    (error-message-string err))
           nil)))


(my/load-softly "~/.emacs.d/config/core.el")
(my/load-softly "~/.emacs.d/config/package-manager.el")
(my/load-softly "~/.emacs.d/config/magit.el")
(my/load-softly "~/.emacs.d/config/good-scroll.el")
(org-babel-load-file "~/.emacs.d/config/elfeed.org")

(setq-default org-confirm-babel-evaluate nil)
(straight-use-package 'solarized-theme)
(load-theme 'solarized-light t)

;; Functions

(defun test ()
  (interactive)
  (message "This is a test!"))

(defun define-multiple-keys (map bindings)
  (dolist (b bindings)
    (define-key map (kbd (car b)) (nth 1 b))))

(defun jump-to-mark ()
  (interactive)
  (goto-char (mark-marker)))

(defun kill-all-word ()
  (interactive)
  (call-interactively 'left-word)
  (call-interactively 'kill-word))

(defun mark-whole-word ()
  (interactive)
  (call-interactively 'right-word)
  (call-interactively 'left-word)
  (call-interactively 'mark-word))

(defun indent-buffer ()
  (interactive)
  (call-interactively 'mark-whole-buffer)
  (call-interactively 'indent-region))

(defun insert-at-start-of-text ()
  (interactive)
  (call-interactively 'beginning-of-line-text)
  (call-interactively 'abnormal-mode))

(defun insert-at-new-line ()
  (interactive)
  (call-interactively 'end-of-line)
  (call-interactively 'newline)
  (call-interactively 'abnormal-mode))

(defun mark-line ()
  (interactive)
  (call-interactively 'beginning-of-visual-line)
  (call-interactively 'next-line)
  (call-interactively 'beginning-of-visual-line)
  (call-interactively 'set-mark-command)
  (call-interactively 'previous-line)
  (call-interactively 'beginning-of-visual-line))

(defun insert-at-end-of-line ()
  (interactive)
  (call-interactively 'end-of-line)
  (call-interactively 'abnormal-mode))


(defun mpv-play-url (url &rest args)
  (interactive)
  (start-process "mpv" nil "mpv" url))


(defun my/find-config-file ()
  (interactive)
  (cd user-emacs-directory)
  (call-interactively 'find-file))


;; keybinds
(global-set-key (kbd "C-c C-c") 'abnormal-mode)

(define-multiple-keys
  abnormal-mode-map
  '(
    ("A"  insert-at-end-of-line)
    ("b"  nil)
    ("bk" kill-this-buffer)
    ("bb" mode-line-other-buffer)
    ("bi" indent-buffer)
    ("c"  kill-ring-save)
    ("d"  delete-region)
    ("D"  kill-whole-line)
    ("e"  eval-buffer)
    ("f"  nil)
    ("fc" my/find-config-file)
    ("ff" find-file)
    ("fo" find-file-at-point)
    ("F"  toggle-frame-fullscreen)
    ("g"  nil)
    ("gg" nil)
    ("G"  end-of-buffer)
    ("h"  left-char)
    ("H"  nil)
    ("HH" apropos)
    ("HC" describe-command)
    ("HF" describe-function)
    ("HK" describe-key)
    ("i"  abnormal-mode)
    ("I"  insert-at-start-of-text)
    ("j"  next-line)
    ("J"  nil)
    ("JM" jump-to-mark)
    ("k"  previous-line)
    ("l"  right-char)
    ("o"  insert-at-new-line)
    ("p"  yank)
    ("Q"  nil)
    ("QQ" save-buffers-kill-emacs)
    ("s"  basic-save-buffer)
    ("u"  undo)
    ("V"  mark-line)
    ("w"  mark-whole-word)
    ("Y"  test)
    ("x"  delete-forward-char)
    (":"  execute-extended-command)
    ("#"  comment-or-uncomment-region)
    ))



(add-hook
 'magit-mode-hook
 (lambda ()
   (define-multiple-keys
     magit-mode-map
     '(
       ("H"        magit-discard)
       ("j"        magit-next-line)
       ("J"        magit-status-jump)
       ("k"        magit-previous-line)
       ("<escape>" magit-mode-bury-buffer)
       ))))

(add-hook
 'org-mode-hook
 (lambda ()
   (define-multiple-keys
     abnormal-mode-map
     '(
       ("<return>" org-edit-special)
       ))))

(add-hook 'with-editor-mode-hook 'abnormal-mode)
(add-hook
 'with-editor-mode-hook
 (lambda ()
   (define-multiple-keys
     abnormal-mode-map
     '(
       ("qf" with-editor-finish)
       ("qc" with-editor-cancel)
       ))))
