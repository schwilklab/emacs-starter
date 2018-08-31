;;; -*- Mode: Emacs-Lisp -*-
;;;;---------------------------------------------------------------------------
;; modes.el configuration file
;; author: Dylan Schwilk
;;
;; Provides hooks and customizations for various modes (text, markdown, LaTeX
;; and bibtex, html, C, C++, python, ess (R and julia).
;;
;; All org-mode customizations are in ~/.emacs.d/lisp/org-mode-setup.el
;;;;---------------------------------------------------------------------------

;;;---------------------------------------------------------------------------
;;; Version control setup
;; ---------------------------------------------------------------------------
;; magit installed via MELPA, See http://magit.github.io/magit/magit.html
;; git-commit-mode installed via MELPA

;; All below should be automatic as part of git-commit-mode other than turning
;; off visual line mode.
(add-hook 'git-commit-mode-hook (lambda ()
  (visual-line-mode -1)
  (auto-fill-mode t)
  (setq fill-column git-commit-fill-column)
))
;; End setup version control -------------------------------------------------

;;;----------------------------------------------------------------------------
;;; Various text modes setup
;; ---------------------------------------------------------------------------

;; Overall text-mode settings
(require 'table)
(add-hook 'text-mode-hook '(lambda()
  (setq visual-wrap-column 79)
  (visual-line-mode)
  ;; and for when we turn off visual-line-mode:
  (setq fill-column 79)
  (flyspell-mode)
  (table-recognize) ; use table.el
))

;; ----------------------------------------------------------------------------
;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-hook 'markdown-mode-hook 'turn-on-pandoc) ;; pandoc-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;; End setup text modes -------------------------------------------------------


;; ----------------------------------------------------------------------------
;; Setup HTML

;; Use tidy.el to provide support for tidy
(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)

;;;----------------------------------------------------------------------------
;; Setup C, C++ mode
(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'c-mode-common-hook "cc-mode" "C Mode Hooks" t)
(autoload 'c-add-style "cc-mode" "Add coding style" t)

;; Associate extensions with c modes
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;; Use K&R c coding style
(setq c-default-style "k&r")

;; End setup c mode -----------------------------------------------------------

;;;----------------------------------------------------------------------------
;; Setup comint mode (command-line-interpreter) for R, julia, python, shell etc
(setq ansi-color-for-comint-mode t) ;; show ansi terminal colors
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;;;----------------------------------------------------------------------------
;; python mode

;; Send current line to interpreter window (bound to C-return like in ESS)
(defun my-python-send-line ()
 (interactive)
  (save-excursion
  (setq the_script_buffer (format (buffer-name)))
  (end-of-line)
  (kill-region (point) (progn (back-to-indentation) (point)))
  ;(setq the_py_buffer (format "*Python[%s]*" (buffer-file-name)))
  (setq the_py_buffer "*Python*")
  (switch-to-buffer-other-window  the_py_buffer)
  (goto-char (buffer-end 1))
  (yank)
  (comint-send-input)
  (switch-to-buffer-other-window the_script_buffer)
  (yank)
  )
  (next-line)
)
;; End setup python-mode-------------------------------------------------------

;;;----------------------------------------------------------------------------
;; Setup ESS for R and julia
(require 'ess-site)

(add-hook 'ess-mode-hook (lambda ()
  ; turn off aligning single '#' to col 40
  (setq ess-indent-with-fancy-comments nil)
  (setq ess-ask-for-ess-directory nil)
  (setq ess-nuke-trailing-whitespace-p t)
  (setq ess-smart-S-assign-key ";") ; use ";" as shortcut for <-
  (ess-toggle-S-assign nil) ; Takes two calls
  (ess-toggle-S-assign nil) ; See documentation for ess-smart-S-assign-key
  (setq ess-swv-processor 'knitr) ; use knitr as default engine, not sweave
  (ess-set-style 'RStudio) ; because collaboration
  (setq ess-directory-function (lambda () default-directory))
  ))
;; End setup ESS  -------------------------------------------------------------

;; ----------------------------------------------------------------------------
;; Setup Latex mode
(add-hook 'LaTeX-mode-hook (lambda ()
  (setq TeX-fold-mode 1)    ;; turn on folding
;;  (setq-default TeX-engine 'xetex) ;; XeTeX  Best to set on per file basis
;;  (setq-default TeX-PDF-mode t)  ;; PDF with XeTeX
  (setq TeX-newline-function 'reindent-then-newline-and-indent)
  (setq LaTeX-item-indent 2)
  (setq TeX-brace-indent-level 2)
  (setq ispell-check-comments nil)
  (setq font-latex-match-textual-keywords
     (quote ("citet" "citep" "citeauthor" "citeyear")))
))

(font-lock-add-keywords
 'latex-mode
 '(("\\\\clearpage" 0 font-lock-keyword-face prepend)
  ("\\\\label" 0 font-lock-keyword-face prepend)))

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(setq TeX-show-compilation nil) ;; turn off compilation buffer

;; Enable synctex correlation
(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows as "latex" pdflatex
;; is actually called
(setq LaTeX-command "latex -synctex=1")

;; RefTeX
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)


(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(add-hook 'markdown-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


; RefTeX for pandoc style citations in markdown and org-mode
(defun pandoc-reftex-setup ()
  (turn-on-reftex)
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
    (progn
      ; enable auto-revert-mode to update reftex when bibtex file changes on disk
      (global-auto-revert-mode t)
      (reftex-parse-all)
      ; pandoc-style citations. Multiple selections do not get correct
      ; semi-colon separator
      (reftex-set-cite-format '((?\C-m . "[@%l]")                 
)))))
(add-hook 'markdown-mode-hook 'pandoc-reftex-setup)
;(add-hook 'org-mode-hook 'pandoc-reftex-setup) ; if you use ox-pandoc

;; For LaTeX:
(eval-after-load 'reftex-vars
  '(progn
     ;; cite format for bibtex/natbiib and biblatex
     (setq reftex-cite-format
       '((?\C-m . "\\cite[]{%l}")
         (?p . "\\citep[][]{%l}")  ; natbib
         (?t . "\\citet[][]{%l}")  ; natbib
         (?F . "\\footcite[][]{%l}")
         (?T . "\\textcite[]{%l}")
         (?P . "\\parencite[]{%l}")
         (?o . "\\citepr[]{%l}")
         (?n . "\\nocite{%l}")))))

(setq font-latex-match-reference-keywords
      '(("cite" "[{")
        ("citep" "[{")  ;; for natbib
        ("cites" "[{}]")
        ("footcite" "[{")
        ("footcites" "[{")
        ("parencite" "[{")
        ("textcite" "[{")
        ("fullcite" "[{")
        ("citetitle" "[{")
        ("citetitles" "[{")
        ("headlessfullcite" "[{")))

(setq reftex-cite-prompt-optional-args nil)
(setq reftex-cite-cleanup-optional-args t)

;; BibTeX-mode Get bibtex mode to autogenerate keys that match schwilk database
;; style
(setq bibtex-autokey-preserve-case t)
(setq bibtex-autokey-names 2)
(setq bibtex-autokey-name-separator "+")
(setq bibtex-autokey-year-length 4)
(setq  bibtex-autokey-title-terminators ".") ;; no title
(setq bibtex-autokey-name-year-separator "-")
(setq bibtex-autokey-additional-names "+etal")
(defun dws-do-nothing (tstr) tstr)
(setq bibtex-autokey-name-case-convert-function 'dws-do-nothing)
(setq bibtex-autokey-edit-before-use nil)
