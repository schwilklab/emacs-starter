;;; -*- Mode: Emacs-Lisp -*-
;;;;---------------------------------------------------------------------------
;; theme.el configuration file
;; author: Dylan Schwilk
;;
;;; Theme-related housekeeping such as frame setup. Actual theme to load selected
;;; below. Default is Schwilk color theme.
;;;;---------------------------------------------------------------------------

;; set color theme here (from themes in ~/.emacs.d/themes/):
(setq the-color-theme 'schwilk)

;; change frame size depending on resolution
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 140 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    (if (> (x-display-pixel-width) 1280)
        (add-to-list 'default-frame-alist (cons 'width 140))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a hundred pixels from the screen height (for
    ;; panels, menubars and whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
      (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

;; Dynamic fonts
(require 'dynamic-fonts)
(setq dynamic-fonts-preferred-proportional-fonts
      '("Source Sans Pro" "DejaVu Sans" "Helvetica"))
  
(setq dynamic-fonts-preferred-monospace-fonts
      '("Inconsolata" "Ubuntu Mono" "Consolas" "Source Code Pro" "Envy Code R"
        "Droid Sans Mono Pro" "Droid Sans Mono" "DejaVu Sans Mono"))

(setq dynamic-fonts-preferred-monospace-point-size 14)
(setq dynamic-fonts-preferred-proportional-point-size 14)

;; Unicode fonts
(require 'unicode-fonts) ;; creates fallback unicode mappings

(defun dws-start-theme ()
   (set-frame-size-according-to-resolution)
   (load-theme the-color-theme t)
   (dynamic-fonts-setup)
   (unicode-fonts-setup)
  )

;; Now setup the theme.
(defun dws-setup-frame (new-frame)
   (select-frame new-frame)
   (dws-start-theme)
)

;; if starting daemon, add hook to load theme, otherwise load theme
(if (daemonp)
    (add-hook 'after-make-frame-functions 'dws-setup-frame)
    (dws-start-theme)
)

;; and this to get window focus:
(defun px-raise-frame-and-give-focus ()
  (when window-system
    (raise-frame)
    (x-focus-frame (selected-frame))
    (set-mouse-pixel-position (selected-frame) 4 4)
    ))
(add-hook 'server-switch-hook 'px-raise-frame-and-give-focus)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set modeline
;; use setq-default to set it for /all/ modes
;;(setq mode-line-format
;; This could be wrapped up the the schwilk-theme
(setq-default mode-line-format
  (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
      (propertize "%02l" 'face 'font-lock-type-face 'help-echo "Line number")
       ","
      (propertize "%02c" 'face 'font-lock-type-face 'help-echo "Column number")
    ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face
                     'help-echo "Relative position") ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face
                     'help-echo "Buffer size") ;; size
    "] "

    ;; the current major mode for the buffer.
    "["

    '(:eval (propertize "%m" 'face 'font-lock-string-face
              'help-echo "Major mode"))
    "] "


    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
              'face 'font-lock-preprocessor-face
              'help-echo (concat "Buffer is in "
                           (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (and (buffer-modified-p) (not buffer-read-only) )
              (concat ","  (propertize "Unsaved"
                             'face 'font-lock-variable-name-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only"))))  
    "] "

    ;; add the time, with the date
    '(:eval (propertize (format-time-string "%H:%M")
              'help-echo
              (format-time-string "%c")))
    " --"
    ;; I don't want to see minor-modes; but if you want, uncomment this:
    ;;minor-mode-alist  ;; list of minor modes
    "%-" ;; fill with '-'
    ))
;; end set modeline
