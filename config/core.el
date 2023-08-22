(setq-default cursor-type 'bar)
(setq debug-on-error t)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; (global-unset-key (kbd "<escape> <escape> <escape>"))


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
