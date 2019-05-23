;;; -*- Mode: Emacs-Lisp -*-
;;;;---------------------------------------------------------------------------
;; theme.el configuration file
;; author: Dylan Schwilk
;;
;;; Theme-related housekeeping such as frame setup. Actual theme to load selected
;;; below. Default is Schwilk color theme.
;;;;---------------------------------------------------------------------------

;; Prevent x resources settings from affecting cursor color see
;; https://emacs.stackexchange.com/questions/13291/emacs-cursor-color-is-different-in-daemon-and-non-daemon-modes
(setq inhibit-x-resources t)

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
(unicode-fonts-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; and this to get window focus:
;; (defun px-raise-frame-and-give-focus ()
;;   (when window-system
;;     (raise-frame)
;;     (x-focus-frame (selected-frame))
;;     (set-mouse-pixel-position (selected-frame) 4 4)
;;     ))

;; (add-hook 'server-switch-hook 'px-raise-frame-and-give-focus)

;; Setup the new frame.
(defun dws-setup-frame (new-frame)
  (select-frame new-frame)
  (set-frame-size-according-to-resolution)
  (dynamic-fonts-setup)
)

;; add hook to setup frames:
(add-hook 'after-make-frame-functions 'dws-setup-frame)

;; load the color theme (schwilk)
(load-theme the-color-theme t nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set modeline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use smart-line-mode for modeline
(setq sml/no-confirm-load-theme t) ; otherwise, sml/setup must come after load
                                   ; custom file or emacs will prompt for theme
                                   ; safety
(sml/setup)

;; remove some "always on" minor modes from modeline
(setq rm-blacklist
      (format "^ \\(%s\\)$"
              (mapconcat #'identity
                         '("Fly.*" "Ivy" "ElDoc")
                         "\\|")))



;; Below only necessary when running emacs NOT as daemon:
;; setup fonts on this frame if started as regular emacs
(dynamic-fonts-setup)
