;;;;---------------------------------------------------------------------------
;; init.el emacs configuration file
;; author: Dylan W. Schwilk
;;
;; packages supported:
;;   font-lock, auctex, reftex, ess, org-mode
;;
;; Supports modes for: text, LaTeX and bibtex, C, C++, python, html
;;
;; this .emacs file loads several other customization files:
;;        - ~/.emacs.d/lisp/efunc.el  -   custom functions
;;        - ~/.emacs.d/lisp/mode.el   -   modes supported
;;        - ~/.emacs./lisp/ekeys.el   -   key bindings
;;        - ~/.emacs.d/lisp/theme.el  -   modeline and color theme
;;
;; And color themese are in ~/.emacs.d/themes
;;;;---------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Personalization and package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; turn on Common Lisp support
(require 'cl-lib)

;; Identification
(setq user-mail-address "jane.doe@ttu.edu")
(setq user-full-name "Jane Doe")

;; add the elisp directories under ~/emacs to my load path
(defvar home-dir (expand-file-name "~/"))
(defvar emacs-root (concat home-dir ".emacs.d/"))
(cl-labels ((add-path (p)
           (add-to-list 'load-path (concat emacs-root p))))
  (add-path "lisp")              ; my personal elisp code
  (add-path "contrib")           ; put elisp code from other people here
)
;; add path for emacs24 style themes
(add-to-list 'custom-theme-load-path (concat emacs-root "themes"))

;; ELPA Package Management
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        )
)

;; Package setup, taken from
;; https://github.com/zane/dotemacs/blob/master/zane-packages.el#L62
(setq required-packages
      '(auctex
        dynamic-fonts
        ess
        htmlize
        list-utils
        magit
	julia-mode
        markdown-mode
        org-plus-contrib
        ox-pandoc
        pandoc-mode
        unicode-fonts
        ))

(package-initialize)

;; install missing packages
;; see http://technical-dresese.blogspot.com/2012/12/elpa-and-initialization.html
(let ((not-installed (cl-remove-if 'package-installed-p required-packages)))
  (if not-installed
      (if (y-or-n-p (format "there are %d packages to be installed. install them? "
                            (length not-installed)))
          (progn (package-refresh-contents)
                 (dolist (package not-installed)
                   (package-install package))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Options ON/OFF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)           ; Disable the startup splash screen
(setq-default visible-bell t)              ; no beeps, flash on errors
(menu-bar-mode 1)                          ; arg >= 1 enable the menu bar
(tool-bar-mode 1)
(show-paren-mode 1)                        ; Turn on parentheses matching
(setq zmacs-regions t)
(setq-default indent-tabs-mode nil)        ; uses spaces rather than tabs
(setq default-tab-width 4);
(setq delete-key-deletes-forward t)
(setq mouse-yank-at-point t)
(line-number-mode t)
(column-number-mode t)
(setq-default fill-column 79)
(defalias 'yes-or-no-p 'y-or-n-p)     ;; y or n is enough

;; Search and autocompletion
(setq ido-mode 1) ;; Use IDO with flx-ido for both buffer and file completion
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
(setq ido-everywhere t)

;; Windows-style cut-copy-paste
(cua-mode t)
(setq x-select-enable-clipboard t)    ;; cut-paste
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1)               ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)   ;; Standard Windows behaviour
(setq interprogram-paste-function 'x-selection-value)

;; we speak utf-8 here
(set-language-environment "utf-8")
(prefer-coding-system 'utf-8)

(setq sentence-end-double-space nil)
(setq sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fame and windows setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; window splitting:
(setq split-height-threshold 45)
(setq split-width-threshold 100)

;; But Emacs still prefers to split vertically (on top of one another). To
;; prefer side-by-side windows when automatically splitting a single window:
(defun split-window-prefer-horizonally (window)
  "If there's only one window (excluding any possibly active
minibuffer), then split the current window horizontally."
  (if (and (one-window-p t)
           (not (active-minibuffer-window)))
      (let ((split-height-threshold nil))
        (split-window-sensibly window))
    (split-window-sensibly window)))

(setq split-window-preferred-function 'split-window-prefer-horizonally)

;; display various non-editing buffers in their own frames
(setq special-display-buffer-names
      (nconc '("*Backtrace*" "*VC-log*" "*compilation*" "*grep*")
             special-display-buffer-names))
(add-to-list 'special-display-frame-alist '(tool-bar-lines . 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backup and autosave options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq backup-directory-alist `(("." . ,(expand-file-name
                                    (concat emacs-root "backups"))))
      auto-save-file-name-transforms
         `((".*" ,(expand-file-name (concat emacs-root "autosaves"))))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
)
;; create the autosave dir if necessary, since emacs won't.
(make-directory (concat emacs-root "autosaves") t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load all external files for keybindings, modes, color themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mapcar
 'load-library
 '( "modes"        ; various modes configurations
   "efuncs"        ; a bunch of utilities functions
   "ekeys"         ; my key bindings and some aliases
   "theme" ))      ; all the visual stuff goes there

;; Do customize stuff last to override anything reset
(setq custom-file (concat emacs-root "custom.el"))
(load custom-file)

;; Add final message so using C-h l I can see if .emacs failed
(message ".emacs loaded successfully!.")
