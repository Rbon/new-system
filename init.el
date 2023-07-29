(setq-default cursor-type 'bar)
(setq debug-on-error t)

;; abnormal mode {
(make-variable-buffer-local
 (defvar abnormal-mode nil
   "Toggle dotcrafter basic mode."))

(defvar abnormal-mode-map (make-sparse-keymap)
  "The keymap for abnormal-mode.")

(defvar abnormal-mode-hook nil
  "The hook for abnormal-mode.")

(add-to-list 'minor-mode-alist '(abnormal-mode " abnormal"))
(add-to-list 'minor-mode-map-alist (cons 'abnormal-mode abnormal-mode-map))





(defun abnormal-mode ()
  (interactive)
  (setq abnormal-mode (not abnormal-mode))

  ;; Take some action when enabled or disabled
  (if abnormal-mode
      (progn
	(message "abnormal-mode activated!")
	(setq cursor-type 'box)
	(global-unset-key (kbd "<escape>")))
    (progn
      (message "abnormal-mode deactivated!")
      (setq cursor-type 'bar)
      (global-set-key (kbd "<escape>") 'abnormal-mode))))

(defun abnormal-init ()
  (abnormal-mode))

(add-hook 'apropos-mode-hook    #'abnormal-mode)
(add-hook 'emacs-lisp-mode-hook #'abnormal-mode)
(add-hook 'help-mode-hook       #'abnormal-mode)
(add-hook 'debugger-mode-hook   #'abnormal-mode)

;; Define a key in the keymap
(define-key abnormal-mode-map (kbd "C-c C-. t")
  (lambda ()
    (interactive)
    (message "abnormal key binding used!")))

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

(defun bootstrap ()
  "Initialize the package manager."
  (interactive)
  (setq straight-use-backage-by-default t)
  
  (defvar bootstrap-version)
  (let ((bootstrap-file
	 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
	(bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
	  (url-retrieve-synchronously
	   "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	   'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  (straight-use-package 'use-package)
  (setq use-package-verbose t)
  (setq use-package-always-defer t))

(defun sync-packages ()
  "Only do this after running bootstrap."
  (interactive)
  (straight-use-package 'magit))

;; keybinds
(global-set-key (kbd "<escape>") 'abnormal-mode)

(define-multiple-keys
  abnormal-mode-map
  '(
    ("A"  insert-at-end-of-line)
    ("b"  nil)
    ("bd" kill-buffer)
    ("bb" previous-buffer)
    ("bi" indent-buffer)
    ("c"  kill-ring-save)
    ("d"  delete-region)
    ("D"  kill-whole-line)
    ("e"  eval-buffer)
    ("F"  find-file)
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
    ("QQ" kill-emacs)
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
