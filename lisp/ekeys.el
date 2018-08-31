;;; -*- Mode: Emacs-Lisp -*-
;;;;---------------------------------------------------------------------------
;; ekeys.el configuration file
;;
;;; Global key bindings and aliases for emacs
;;;;---------------------------------------------------------------------------

(defmacro bind-key (key function)
  `(progn
     (global-set-key (read-kbd-macro ,key) ,function)))

(defun bind-keys (bindings)
  (if (eq (cdr bindings) nil)
      t
      (progn
        (let ((key (car bindings))
              (function (cadr bindings)))
          (bind-key key function)
          (bind-keys (cddr bindings))))))

(bind-keys
'(
  ;; Function keys:
  ;; f1 - help
  ;; f2 - 2-column
  ;; f3 - define kbd macro
  "<f8>"    compile
  "<f11>"   visual-line-mode ; toggles
  "<f12>"   toggle-truncate-lines

  ;; for moving to `M-x compile' and `M-x grep' matches
  "C-c n"   next-error
  "C-c p"   previous-error

   ;; additional shortcuts buffers and windows
  ;; "C-<tab>" bury-buffer ; cycle through buffers
  "C-x I"   insert-buffer
  "C-c w"   count-words-region
  "M-/"     hippie-expand

  ;; org-mode
  "C-c l"   org-store-link
  "C-c a"   org-agenda
  "C-c b"   org-iswitchb
  "C-c c"   org-capture  

  ;; Start shell or switch to it if it's active.
  "C-x m"   shell
  ;; magit for git
  "C-x g"   magit-status

  ;; bindings for functions defined in lisp/efuncs.el
   "C-c \\" the-the
   "C-c d"  insert-date-string
))

;; Get ess-like send line to interpreter in python mode
(add-hook 'python-mode-hook (lambda ()
    (define-key python-mode-map (kbd "<C-return>")
    'my-python-send-line)))

;; Rebind Alt-q to maybe-fill-paragraph so we don't use alt-q to fill when we
;; are in visual-line-mode
(add-hook 'text-mode-hook '(lambda ()
  (define-key text-mode-map "\M-q" 'maybe-fill-paragraph)))

;; Define eval line in ESS as shift-enter rather than C-enter. because C-enter
;; conflicts with the rectangle selection tool in CUA-mode.
(define-key ess-mode-map [(control return)] nil)
(define-key ess-mode-map [(shift return)] 'ess-eval-region-or-line-and-step)
