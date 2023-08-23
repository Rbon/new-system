(setq-default cursor-type 'bar)
(setq debug-on-error t)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; (global-unset-key (kbd "<escape> <escape> <escape>"))
(require 'org-tempo)
;; (setq-default org-confirm-babel-evaluate nil)
(global-set-key (kbd "C-c C-c") 'abnormal-mode)

;; abnormal mode {
;; (make-variable-buffer-local
;; (defvar abnormal-mode nil
;;   "Toggle dotcrafter basic mode."))
(define-minor-mode abnormal-mode
  "It's not normal."
  :init-value nil)

(defvar abnormal-mode-map (make-sparse-keymap)
  "The keymap for abnormal-mode.")

(defvar abnormal-mode-hook nil
  "The hook for abnormal-mode.")

; (setq-default abnormal-mode t)
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

(add-hook 'apropos-mode-hook     #'abnormal-mode)
(add-hook 'emacs-lisp-mode-hook  #'abnormal-mode)
(add-hook 'help-mode-hook        #'abnormal-mode)
(add-hook 'debugger-mode-hook    #'abnormal-mode)
(add-hook 'org-mode-hook         #'abnormal-mode)

;; Define a key in the keymap
(define-key abnormal-mode-map (kbd "C-c C-. t")
  (lambda ()
    (interactive)
    (message "abnormal key binding used!")))
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
