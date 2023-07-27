(global-set-key (kbd "<escape>") 'abnormal-mode)
(setq-default cursor-type 'bar)

;; abnormal mode {
(make-variable-buffer-local
 (defvar abnormal-mode nil
   "Toggle dotcrafter basic mode."))

(defvar abnormal-mode-map (make-sparse-keymap)
  "The keymap for abnormal-mode.")

;; Define a key in the keymap
(define-key abnormal-mode-map (kbd "C-c C-. t")
  (lambda ()
    (interactive)
    (message "abnormal key binding used!")))

(defun test ()
  (interactive)
  (message "This is a test!"))

(defun add-to-abnormal-mode-map (bindings)
  (dolist (b bindings)
	  (define-key abnormal-mode-map (kbd (car b)) (nth 1 b))))

;;(defun my-mark-word (N)
;;  (interactive "p")
;;  (if (and
;;       (not (e

;; keybinds
(add-to-abnormal-mode-map '(
			    ("i"  abnormal-mode)
			    ("Y"  test)
			    ("h"  left-char)
			    ("j"  next-line)
			    ("k"  previous-line)
			    ("l"  right-char)
			    ("s"  basic-save-buffer)
			    ("D"  kill-whole-line)
			    ("w"  mark-whole-word)
			    ("e"  eval-buffer)
			    (":"  execute-extended-command)
			    ("u"  undo)
			    ("H"  nil)
			    ("HH" apropos)
			    ("HK" describe-key)
			    ))
			   
(add-to-list 'minor-mode-alist '(abnormal-mode " abnormal"))
(add-to-list 'minor-mode-map-alist (cons 'abnormal-mode abnormal-mode-map))

(defun abnormal-mode (&optional ARG)
  (interactive (list 'toggle))
  (setq abnormal-mode
	(if (eq ARG 'toggle)
	    (not abnormal-mode)
	  (> ARG 0)))

  ;; Take someaction when enabled or disabled
  (if abnormal-mode
      (progn
	(message "abnormal-mode activated!")
	(setq cursor-type 'box)
	(global-unset-key (kbd "<escape>")))
    (progn
      (message "abnormal-mode deactivated!")
      (setq cursor-type 'bar)
      (global-set-key (kbd "<escape>") 'abnormal-mode))))

;; Other stuff

(defun kill-all-word ()
    (interactive)
  (call-interactively 'left-word)
  (call-interactively 'kill-word))

(defun mark-whole-word ()
  (interactive)
  (call-interactively 'right-word)
  (call-interactively 'left-word)
  (call-interactively 'mark-word))

(defun bad-mark-whole-word (&optional arg allow-extend)
  "Stolen from stackexchange."
  (interactive "P\np")
  (let ((num  ((prefix-numeric-value arg)))
	(unless (eq last-command this-command)
	  (if (natnump num)
	      (skip-syntax-forward "\\s-")
	    (skip-syntax-backward "\\s-")))
	(unless (or (eq last-command this-command)
		    (if (natnump num)
			(looking-at "\\b")
		      (loking-back "\\b")))
	  (if (natnump num)
	      (left-word)
	    (right-word)))
	(mark-word arg allow-extend))))
