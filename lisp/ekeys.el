;;; -*- Mode: Emacs-Lisp -*-
;;;;---------------------------------------------------------------------------
;; ekeys.el configuration file
;; author: Dylan Schwilk
;;
;;; my key bindings and aliases for emacs. I put even the mode-specific
;;; bindings here so I know where to look for keybindings.
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
   "<f12>" toggle-truncate-lines

  ;; for moving to `M-x compile' and `M-x grep' matches
  "C-c n"   next-error
  "C-c p"   previous-error

   ;; additional shortcuts buffers and windows
  "C-<tab>"   bury-buffer ; cycle through buffers
  "C-x E"   apply-macro-to-region-lines
  "C-x I"   insert-buffer
  "C-c s"   swap-windows  ; defined in efuncs.el
  "C-c w"   count-words-region
  "M-/"     hippie-expand

  ;; org-mode
  "C-c l"   org-store-link
  "C-c a"   org-agenda
  "C-c b"   org-iswitchb
  "C-c c"   org-capture  
  "<f5>"    dws/org-todo
  "<S-f5>"  dws/widen

  ;; Start shell or switch to it if it's active.
 "C-x m"   shell
  ;; Programming and ess
  "<f8>"    compile
  ;; git, magit, vc
  "C-x g"   magit-status

  ;; bindings for functions defined in lisp/efuncs.el
   "C-c r"   rename-file-and-buffer
   "C-c \\"  the-the
   "C-c i"   insert-date-string
   "C-c k"   browse-kill-ring
 ; "\C-cr"   replace-garbage-chars ;; replaces MS-windows \222, etc
  ;; Browse url
 ; [(shift button3)] browse-url-at-mouse
 ; "C-c b"   browse-url
))


;; disable iconify --- to easy to do on accident
(when window-system
  (global-unset-key (kbd "C-z")))

;; aliases
(defalias 'qrr 'query-replace-regexp)
(defalias 'rr 'replace-regexp)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode specific bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add occur to isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

;; Don't fill when we are in visual-line-mode
(add-hook 'text-mode-hook
  (defun cjm-fix-text-mode ()
    (define-key text-mode-map "\M-q" 'maybe-fill-paragraph)
    (remove-hook 'text-mode-hook 'cjm-fix-text-mode)))

;; ESS mode hooks
(add-hook 'ess-mode-hook
  (lambda()
    (local-set-key [(control return)] nil)
    (local-set-key [(shift return)] 'ess-eval-region-or-line-and-step) ;; start ess
    (local-set-key [C-up] 'comint-previous-input) ;; like alt-p
    (local-set-key [C-down] 'comint-next-input)
   )
)

;; HTML mode keys
(add-hook 'html-mode-hook
  (lambda()
    (local-set-key "\C-xt" 'tidy=region)))
