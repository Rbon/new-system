(global-set-key (kbd "M-SPC") 'abnormal-mode)
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

;; keybinds
(add-to-abnormal-mode-map '(
			    ("I" test)
			    ("Y" test)
			    ("h" left-char)
			    ("j" next-line)
			    ("k" previous-line)
			    ("l" right-char)
			    ("s" basic-save-buffer)
			    ("D" kill-whole-line)
			    ("w" kill-all-word)
			    ("e" eval-buffer)
			    ("u" undo)
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
	(setq cursor-type 'box))
    (progn
      (message "abnormal-mode deactivated!")
      (setq cursor-type 'bar))))

;; Other stuff

(defun kill-all-word ()
    (interactive)
  (call-interactively 'left-word)
  (call-interactively 'kill-word))
