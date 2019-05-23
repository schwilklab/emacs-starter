;;; schwilk-theme.el --- A dark theme for Emacs.

;; Copyright (C) 2013-2018 Dylan Schwilk 

;; Author: Dylan Schwilk <dylan@schwilk.org>
;; Version: 0.2

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Credits:

;;  Based on zenburn.el (by Bozhidar Batsov, <bozhidar@batsov.com> URL:
;; http://github.com/bbatsov/zenburn-emacs)

;; Jani Nurminen created the original theme for vim on such this port
;; is based.

;;; Code:

(deftheme schwilk "The Schwilk color theme")

;;; Color Palette

(defvar schwilk-colors-alist
  '(("schwilk-fg"       . "#DCDCCC")
    ("schwilk-fg-1"     . "#656555")
    ("schwilk-bg-1"     . "#0F0F0F")
    ("schwilk-bg-05"    . "#171717")
    ("schwilk-bg"       . "#1F1F1F")
    ("schwilk-bg+1"     . "#2F2F2F")
    ("schwilk-bg+2"     . "#3F3F3F")
    ("schwilk-bg+3"     . "#4F4F4F")
    ("schwilk-red+1"    . "#ECB3B3")
    ("schwilk-red"      . "#CC9393")
    ("schwilk-red-1"    . "#BC8383")
    ("schwilk-red-2"    . "#AC7373")
    ("schwilk-red-3"    . "#9C6363")
    ("schwilk-red-4"    . "#8C5353")
    ("schwilk-orange"   . "#FFB272")
    ("schwilk-orange-1" . "#FA943E")
    ("schwilk-orange-red" . "#FB6246")
    ("schwilk-yellow"   . "#F0DFAF")
    ("schwilk-yellow-1" . "#E0CF9F")
    ("schwilk-yellow-2" . "#D0BF8F")
    ("schwilk-green-1"  . "#1F8A1F") 
    ("schwilk-green"    . "#5FD45F")
    ("schwilk-green+1"  . "#89EA89") 
    ("schwilk-green+2"  . "#A3EAA3")
    ("schwilk-green+3"  . "#B3FAB3")
    ("schwilk-green+4"  . "#C3FFC3")
    ("schwilk-cyan"     . "#93E0E3")
    ("schwilk-blue+1"   . "#C0FAF2") 
    ("schwilk-blue"     . "#8EF5E6") 
    ("schwilk-blue-1"   . "#7FD7D7")
    ("schwilk-blue-2"   . "#4A7F7F")
    ("schwilk-blue-3"   . "#3A6F6F")
    ("schwilk-blue-4"   . "#2A5F5F")
    ("schwilk-blue-5"   . "#1A4F4F")
    ("schwilk-blue-6"   . "#0A3F3F")
    ("schwilk-magenta"  . "#DC8CC3"))
  "List of Schwilk colors.
Each element has the form (NAME . HEX).
`+N' suffixes indicate a color is lighter.
`-N' suffixes indicate a color is darker.")


(defmacro schwilk-with-color-variables (&rest body)
  "`let' bind all colors defined in `schwilk-colors-alist'.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   schwilk-colors-alist))
     ,@body))

;;; Theme Faces
(schwilk-with-color-variables
  (custom-theme-set-faces
   'schwilk
;;;; Built-in
;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,schwilk-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,schwilk-yellow-2 :underline t :weight normal))))
   `(default ((t (:foreground ,schwilk-fg :background ,schwilk-bg))))
   `(cursor ((t (:foreground ,schwilk-fg-1 :background "white"))))
   `(escape-glyph ((t (:foreground ,schwilk-yellow :bold t))))
   `(fringe ((t (:foreground ,schwilk-fg :background ,schwilk-bg+1))))
   `(header-line ((t (:foreground ,schwilk-yellow
                                  :background ,schwilk-bg-1
                                  :box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,schwilk-bg+2))))
   `(region ((,class (:background ,schwilk-bg+2))
             (t :inverse-video t)))
   `(success ((t (:foreground ,schwilk-green :weight bold))))
   `(warning ((t (:foreground ,schwilk-orange-1 :weight bold))))
   `(error ((t (:foreground ,schwilk-orange-red :weight bold))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,schwilk-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,schwilk-green))))
   `(compilation-error-face ((t (:inherit error :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,schwilk-fg))))
   `(compilation-info-face ((t (:foreground ,schwilk-blue))))
   `(compilation-info ((t (:foreground ,schwilk-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,schwilk-green))))
   `(compilation-line-face ((t (:foreground ,schwilk-yellow))))
   `(compilation-line-number ((t (:foreground ,schwilk-yellow))))
   `(compilation-message-face ((t (:foreground ,schwilk-blue))))
   `(compilation-warning-face ((t (:inherit warning :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,schwilk-green+2 :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,schwilk-red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,schwilk-yellow :weight bold))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,schwilk-fg))))
   `(grep-error-face ((t (:foreground ,schwilk-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,schwilk-blue))))
   `(grep-match-face ((t (:foreground ,schwilk-orange :weight bold))))
   `(match ((t (:background ,schwilk-bg-1 :foreground ,schwilk-orange :weight bold))))
;;;;; isearch
   `(isearch ((t (:foreground ,schwilk-yellow-2 :weight bold :background ,schwilk-bg-1))))
   `(isearch-fail ((t (:foreground ,schwilk-fg :background ,schwilk-red-4))))
   `(lazy-highlight ((t (:foreground ,schwilk-yellow-2 :weight bold :background ,schwilk-bg-05))))
;;;;; menu and mode line
   `(menu ((t (:foreground ,schwilk-fg :background ,schwilk-bg))))
   `(minibuffer-prompt ((t (:foreground ,schwilk-yellow))))
   `(mode-line
     ((,class (:foreground ,schwilk-green+1
                           :background ,schwilk-bg-1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,schwilk-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,schwilk-green-1
                      :background ,schwilk-bg-05
                      :box (:line-width -1 :style released-button)))))
   `(secondary-selection ((t (:background ,schwilk-bg+2))))
   `(trailing-whitespace ((t (:background ,schwilk-red))))
   `(vertical-border ((t (:foreground ,schwilk-fg))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,schwilk-cyan))))
   `(font-lock-comment-face ((t (:foreground ,schwilk-red))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,schwilk-red))))
   `(font-lock-constant-face ((t (:foreground ,schwilk-green+4))))
   `(font-lock-doc-face ((t (:foreground ,schwilk-green))))
   `(font-lock-doc-string-face ((t (:foreground ,schwilk-blue))))
   `(font-lock-function-name-face ((t (:foreground ,schwilk-blue+1))))
   `(font-lock-keyword-face ((t (:foreground ,schwilk-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,schwilk-fg))))
   `(font-lock-preprocessor-face ((t (:foreground ,schwilk-blue-1))))
   `(font-lock-string-face ((t (:foreground ,schwilk-green))))
   `(font-lock-type-face ((t (:foreground ,schwilk-yellow-2))))
   `(font-lock-variable-name-face ((t (:foreground ,schwilk-orange))))
   `(font-lock-warning-face ((t (:inherit warning))))
   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;;; newsticker
   `(newsticker-date-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-default-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,schwilk-green+3))))
   `(newsticker-extra-face ((t (:foreground ,schwilk-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,schwilk-green))))
   `(newsticker-new-item-face ((t (:foreground ,schwilk-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,schwilk-red))))
   `(newsticker-old-item-face ((t (:foreground ,schwilk-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-treeview-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,schwilk-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,schwilk-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,schwilk-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,schwilk-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,schwilk-bg+3))))
   `(newsticker-treeview-selection-face ((t (:foreground ,schwilk-yellow))))
;;;; Third-party
;;;;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,schwilk-fg-1 :background ,schwilk-bg :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,schwilk-green+2 :background ,schwilk-bg :inverse-video nil))))
;;;;; full-ack
   `(ack-separator ((t (:foreground ,schwilk-fg))))
   `(ack-file ((t (:foreground ,schwilk-blue))))
   `(ack-line ((t (:foreground ,schwilk-yellow))))
   `(ack-match ((t (:foreground ,schwilk-orange :background ,schwilk-bg-1 :weight bold))))
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-italic-face ((t (:foreground ,schwilk-green :slant italic))))
   `(font-latex-warning ((t (:inherit font-lock-warning-face))))
   `(font-latex-string-face ((t (:foreground ,schwilk-green+1))))
   `(font-latex-sedate-face ((t (:foreground ,schwilk-yellow :weight bold ))))
   `(font-latex-verbatim-face ((t (:foreground ,schwilk-yellow-2))))
   `(font-latex-sectioning-1-face ((t (:foreground ,schwilk-orange :weight bold ))))
   `(font-latex-sectioning-2-face ((t (:inherit variable-pitch :foreground ,schwilk-yellow-1 :weight bold ))))
   `(font-latex-sectioning-3-face ((t (:inherit variable-pitch :foreground ,schwilk-yellow-2 :weight bold ))))
   `(font-latex-sectioning-4-face ((t (:inherit variable-pitch :foreground ,schwilk-yellow-2 :weight bold ))))
   `(font-latex-sectioning-5-face ((t (:inherit variable-pitch :foreground ,schwilk-yellow-2 :weight bold ))))
   `(font-latex-title-1-face ((t (:foregrund ,schwilk-orange))))
   `(font-latex-title-4-face ((t (:inherit variable-pitch :weight bold))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,schwilk-bg+3 :foreground "black"))))
   `(ac-selection-face ((t (:background ,schwilk-blue-4 :foreground ,schwilk-fg))))
   `(popup-tip-face ((t (:background ,schwilk-yellow-2 :foreground "black"))))
   `(popup-scroll-bar-foreground-face ((t (:background ,schwilk-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,schwilk-bg-1))))
   `(popup-isearch-match ((t (:background ,schwilk-bg :foreground ,schwilk-fg))))
;;;;; android mode
   `(android-mode-debug-face ((t (:foreground ,schwilk-green+1))))
   `(android-mode-error-face ((t (:inherit error))))
   `(android-mode-info-face ((t (:foreground ,schwilk-fg))))
   `(android-mode-verbose-face ((t (:foreground ,schwilk-green))))
   `(android-mode-warning-face ((t (:inherit warning))))
;;;;; bm
   `(bm-face ((t (:background ,schwilk-yellow-1 :foreground ,schwilk-bg))))
   `(bm-fringe-face ((t (:background ,schwilk-yellow-1 :foreground ,schwilk-bg))))
   `(bm-fringe-persistent-face ((t (:background ,schwilk-green-1 :foreground ,schwilk-bg))))
   `(bm-persistent-face ((t (:background ,schwilk-green-1 :foreground ,schwilk-bg))))
;;;;; clojure-test-mode
   `(clojure-test-failure-face ((t (:foreground ,schwilk-orange :weight bold :underline t))))
   `(clojure-test-error-face ((t (:foreground ,schwilk-red :weight bold :underline t))))
   `(clojure-test-success-face ((t (:foreground ,schwilk-green+1 :weight bold :underline t))))
;;;;; ctable
   `(ctbl:face-cell-select ((t (:background ,schwilk-blue :foreground ,schwilk-bg))))
   `(ctbl:face-continue-bar ((t (:background ,schwilk-bg-05 :foreground ,schwilk-bg))))
   `(ctbl:face-row-select ((t (:background ,schwilk-cyan :foreground ,schwilk-bg))))
;;;;; diff
   `(diff-added ((,class (:foreground ,schwilk-green+4 :background nil))
                 (t (:foreground ,schwilk-green-1 :background nil))))
   `(diff-changed ((t (:foreground ,schwilk-yellow))))
   `(diff-removed ((,class (:foreground ,schwilk-red :background nil))
                   (t (:foreground ,schwilk-red-3 :background nil))))
   `(diff-refine-added ((t :inherit diff-added :weight bold)))
   `(diff-refine-change ((t :inherit diff-changed :weight bold)))
   `(diff-refine-removed ((t :inherit diff-removed :weight bold)))
   `(diff-header ((,class (:background ,schwilk-bg+2))
                  (t (:background ,schwilk-fg :foreground ,schwilk-bg))))
   `(diff-file-header
     ((,class (:background ,schwilk-bg+2 :foreground ,schwilk-fg :bold t))
      (t (:background ,schwilk-fg :foreground ,schwilk-bg :bold t))))
;;;;; dired+
   `(diredp-display-msg ((t (:foreground ,schwilk-blue))))
   `(diredp-compressed-file-suffix ((t (:foreground ,schwilk-orange))))
   `(diredp-date-time ((t (:foreground ,schwilk-magenta))))
   `(diredp-deletion ((t (:foreground ,schwilk-yellow))))
   `(diredp-deletion-file-name ((t (:foreground ,schwilk-red))))
   `(diredp-dir-heading ((t (:foreground ,schwilk-blue :background ,schwilk-bg-1))))
   `(diredp-dir-priv ((t (:foreground ,schwilk-cyan))))
   `(diredp-exec-priv ((t (:foreground ,schwilk-red))))
   `(diredp-executable-tag ((t (:foreground ,schwilk-green+1))))
   `(diredp-file-name ((t (:foreground ,schwilk-blue))))
   `(diredp-file-suffix ((t (:foreground ,schwilk-green))))
   `(diredp-flag-mark ((t (:foreground ,schwilk-yellow))))
   `(diredp-flag-mark-line ((t (:foreground ,schwilk-orange))))
   `(diredp-ignored-file-name ((t (:foreground ,schwilk-red))))
   `(diredp-link-priv ((t (:foreground ,schwilk-yellow))))
   `(diredp-mode-line-flagged ((t (:foreground ,schwilk-yellow))))
   `(diredp-mode-line-marked ((t (:foreground ,schwilk-orange))))
   `(diredp-no-priv ((t (:foreground ,schwilk-fg))))
   `(diredp-number ((t (:foreground ,schwilk-green+1))))
   `(diredp-other-priv ((t (:foreground ,schwilk-yellow-1))))
   `(diredp-rare-priv ((t (:foreground ,schwilk-red-1))))
   `(diredp-read-priv ((t (:foreground ,schwilk-green-1))))
   `(diredp-symlink ((t (:foreground ,schwilk-yellow))))
   `(diredp-write-priv ((t (:foreground ,schwilk-magenta))))
;;;;; ert
   `(ert-test-result-expected ((t (:foreground ,schwilk-green+4 :background ,schwilk-bg))))
   `(ert-test-result-unexpected ((t (:inherit warning))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,schwilk-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,schwilk-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,schwilk-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,schwilk-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,schwilk-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,schwilk-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,schwilk-cyan :weight bold))))
;;;;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-red) :inherit unspecified))
      (t (:foreground ,schwilk-red-1 :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-orange) :inherit unspecified))
      (t (:foreground ,schwilk-orange :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:inherit warning))))
   `(flycheck-fringe-warning ((t (:foreground ,schwilk-orange :weight bold))))
;;;;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,schwilk-red-1 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,schwilk-orange :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,schwilk-green-1 :weight bold :underline t))))
;;;;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-orange) :inherit unspecified))
      (t (:foreground ,schwilk-orange :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,schwilk-red) :inherit unspecified))
      (t (:foreground ,schwilk-red-1 :weight bold :underline t))))
;;;;; erc
   ;;   `(erc-action-face ((t (:inherit erc-default-face))))
   ;; `(erc-bold-face ((t (:weight bold))))
   ;; `(erc-current-nick-face ((t (:foreground ,schwilk-blue :weight bold))))
   ;; `(erc-dangerous-host-face ((t (:inherit font-lock-warning))))
   ;; `(erc-default-face ((t (:foreground ,schwilk-fg))))
   ;; `(erc-direct-msg-face ((t (:inherit erc-default-face))))
   ;; `(erc-error-face ((t (:inherit font-lock-warning))))
   ;; `(erc-fool-face ((t (:inherit erc-default))))
   ;; `(erc-highlight-face ((t (:inherit highlight))))
   ;; `(erc-input-face ((t (:foreground ,schwilk-yellow))))
   ;; `(erc-keyword-face ((t (:foreground ,schwilk-blue :weight bold))))
   ;; `(erc-nick-default-face ((t (:foreground ,schwilk-yellow :weight bold))))
   ;; `(erc-my-nick-face ((t (:foreground ,schwilk-red :weight bold))))
   ;; `(erc-nick-msg-face ((t (:inherit erc-default-face))))
   ;; `(erc-notice-face ((t (:foreground ,schwilk-green))))
   ;; `(erc-pal-face ((t (:foreground ,schwilk-orange :weight bold))))
   ;; `(erc-prompt-face ((t (:foreground ,schwilk-orange :background ,schwilk-bg :weight bold))))
   ;; `(erc-timestamp-face ((t (:foreground ,schwilk-green+1))))
   ;; `(erc-underline-face ((t (:underline t))))
;;;;; git-gutter
   `(git-gutter:added ((t (:foreground ,schwilk-green :weight bold :inverse-video t))))
   `(git-gutter:deleted ((t (:foreground ,schwilk-red :weight bold :inverse-video t))))
   `(git-gutter:modified ((t (:foreground ,schwilk-magenta :weight bold :inverse-video t))))
   `(git-gutter:unchanged ((t (:foreground ,schwilk-fg :weight bold :inverse-video t))))
;;;;; git-gutter-fr
   `(git-gutter-fr:added ((t (:foreground ,schwilk-green :weight bold))))
   `(git-gutter-fr:deleted ((t (:foreground ,schwilk-red :weight bold))))
   `(git-gutter-fr:modified ((t (:foreground ,schwilk-magenta :weight bold))))
;;;;; gnus
   `(gnus-group-mail-1 ((t (:bold t :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:bold t :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:bold t :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:bold t :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:bold t :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:bold t :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:bold t :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:bold t :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:bold t :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:bold t :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:bold t :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:bold t :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:bold t :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:bold t :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-from))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-summary-cancelled ((t (:foreground ,schwilk-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,schwilk-blue))))
   `(gnus-summary-high-read ((t (:foreground ,schwilk-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,schwilk-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,schwilk-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,schwilk-blue))))
   `(gnus-summary-low-read ((t (:foreground ,schwilk-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,schwilk-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,schwilk-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,schwilk-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,schwilk-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,schwilk-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,schwilk-fg))))
   `(gnus-summary-selected ((t (:foreground ,schwilk-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,schwilk-blue))))
   `(gnus-cite-10 ((t (:foreground ,schwilk-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,schwilk-yellow))))
   `(gnus-cite-2 ((t (:foreground ,schwilk-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,schwilk-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,schwilk-green+2))))
   `(gnus-cite-5 ((t (:foreground ,schwilk-green+1))))
   `(gnus-cite-6 ((t (:foreground ,schwilk-green))))
   `(gnus-cite-7 ((t (:foreground ,schwilk-red))))
   `(gnus-cite-8 ((t (:foreground ,schwilk-red-1))))
   `(gnus-cite-9 ((t (:foreground ,schwilk-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,schwilk-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,schwilk-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,schwilk-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,schwilk-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,schwilk-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,schwilk-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,schwilk-bg+2))))
   `(gnus-signature ((t (:foreground ,schwilk-yellow))))
   `(gnus-x ((t (:background ,schwilk-fg :foreground ,schwilk-bg))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,schwilk-blue))))
   `(guide-key/key-face ((t (:foreground ,schwilk-green))))
   `(guide-key/prefix-command-face ((t (:foreground ,schwilk-green+1))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,schwilk-green
                      :background ,schwilk-bg
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,schwilk-yellow
                      :background ,schwilk-bg-1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,schwilk-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,schwilk-bg+1))))
   `(helm-visible-mark ((t (:foreground ,schwilk-bg :background ,schwilk-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,schwilk-green+4 :background ,schwilk-bg-1))))
   `(helm-ff-directory ((t (:foreground ,schwilk-magenta))))
;;;;; hl-line-mode
   `(hl-line-face ((,class (:background ,schwilk-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,schwilk-bg-05)) ; old emacsen
              (t :weight bold)))
;;;;; hl-sexp
   `(hl-sexp-face ((,class (:background ,schwilk-bg+1))
                   (t :weight bold)))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,schwilk-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,schwilk-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,schwilk-yellow))))
;;;;; js2-mode
   `(js2-warning-face ((t (:inherit warning))))
   `(js2-error-face ((t (:foreground ,schwilk-red-3 :weight bold))))
   `(js2-jsdoc-tag-face ((t (:foreground ,schwilk-green-1))))
   `(js2-jsdoc-type-face ((t (:foreground ,schwilk-green+2))))
   `(js2-jsdoc-value-face ((t (:foreground ,schwilk-green+3))))
   `(js2-function-param-face ((t (:foreground, schwilk-green+3))))
   `(js2-external-variable-face ((t (:foreground ,schwilk-orange))))
;;;;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,schwilk-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,schwilk-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,schwilk-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,schwilk-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,schwilk-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,schwilk-red+1))))
   `(jabber-activity-face((t (:foreground ,schwilk-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,schwilk-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))
;;;;; linum-mode
   `(linum ((t (:foreground ,schwilk-green+2 :background ,schwilk-bg))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,schwilk-green+2 :background ,schwilk-bg-1))))
   `(macrostep-gensym-2
     ((t (:foreground ,schwilk-red+1 :background ,schwilk-bg-1))))
   `(macrostep-gensym-3
     ((t (:foreground ,schwilk-blue+1 :background ,schwilk-bg-1))))
   `(macrostep-gensym-4
     ((t (:foreground ,schwilk-magenta :background ,schwilk-bg-1))))
   `(macrostep-gensym-5
     ((t (:foreground ,schwilk-yellow :background ,schwilk-bg-1))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; magit
   `(magit-section-title ((t (:foreground ,schwilk-yellow :weight bold))))
   `(magit-branch ((t (:foreground ,schwilk-orange :weight bold))))
   `(magit-item-highlight ((t (:background ,schwilk-bg+1))))
   `(magit-diff-hunk-header ((t (:background ,schwilk-bg+2))))
   `(git-commit-summary-face ((t (:foreground ,schwilk-yellow :weight bold))))
   `(git-commit-overlong-summary-face ((t (:inherit error :background ,schwilk-bg+2))))
;;;;; egg
   `(egg-text-base ((t (:foreground ,schwilk-fg))))
   `(egg-help-header-1 ((t (:foreground ,schwilk-yellow))))
   `(egg-help-header-2 ((t (:foreground ,schwilk-green+3))))
   `(egg-branch ((t (:foreground ,schwilk-yellow))))
   `(egg-branch-mono ((t (:foreground ,schwilk-yellow))))
   `(egg-term ((t (:foreground ,schwilk-yellow))))
   `(egg-diff-add ((t (:foreground ,schwilk-green+4))))
   `(egg-diff-del ((t (:foreground ,schwilk-red+1))))
   `(egg-diff-file-header ((t (:foreground ,schwilk-yellow-2))))
   `(egg-section-title ((t (:foreground ,schwilk-yellow))))
   `(egg-stash-mono ((t (:foreground ,schwilk-green+4))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,schwilk-green+1))))
   `(message-header-other ((t (:foreground ,schwilk-green))))
   `(message-header-to ((t (:foreground ,schwilk-yellow :weight bold))))
   `(message-header-from ((t (:foreground ,schwilk-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,schwilk-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,schwilk-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,schwilk-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,schwilk-green))))
   `(message-mml ((t (:foreground ,schwilk-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mew
   `(mew-face-header-subject ((t (:foreground ,schwilk-orange))))
   `(mew-face-header-from ((t (:foreground ,schwilk-yellow))))
   `(mew-face-header-date ((t (:foreground ,schwilk-green))))
   `(mew-face-header-to ((t (:foreground ,schwilk-red))))
   `(mew-face-header-key ((t (:foreground ,schwilk-green))))
   `(mew-face-header-private ((t (:foreground ,schwilk-green))))
   `(mew-face-header-important ((t (:foreground ,schwilk-blue))))
   `(mew-face-header-marginal ((t (:foreground ,schwilk-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,schwilk-red))))
   `(mew-face-header-xmew ((t (:foreground ,schwilk-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,schwilk-red))))
   `(mew-face-body-url ((t (:foreground ,schwilk-orange))))
   `(mew-face-body-comment ((t (:foreground ,schwilk-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,schwilk-green))))
   `(mew-face-body-cite2 ((t (:foreground ,schwilk-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,schwilk-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,schwilk-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,schwilk-red))))
   `(mew-face-mark-review ((t (:foreground ,schwilk-blue))))
   `(mew-face-mark-escape ((t (:foreground ,schwilk-green))))
   `(mew-face-mark-delete ((t (:foreground ,schwilk-red))))
   `(mew-face-mark-unlink ((t (:foreground ,schwilk-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,schwilk-green))))
   `(mew-face-mark-unread ((t (:foreground ,schwilk-red-2))))
   `(mew-face-eof-message ((t (:foreground ,schwilk-green))))
   `(mew-face-eof-part ((t (:foreground ,schwilk-yellow))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,schwilk-cyan :background ,schwilk-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,schwilk-bg :background ,schwilk-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,schwilk-bg :background ,schwilk-red :weight bold))))
;;;;; mingus
   `(mingus-directory-face ((t (:foreground ,schwilk-blue))))
   `(mingus-pausing-face ((t (:foreground ,schwilk-magenta))))
   `(mingus-playing-face ((t (:foreground ,schwilk-cyan))))
   `(mingus-playlist-face ((t (:foreground ,schwilk-cyan ))))
   `(mingus-song-file-face ((t (:foreground ,schwilk-yellow))))
   `(mingus-stopped-face ((t (:foreground ,schwilk-red))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,schwilk-yellow))))
   `(nav-face-button-num ((t (:foreground ,schwilk-cyan))))
   `(nav-face-dir ((t (:foreground ,schwilk-green))))
   `(nav-face-hdir ((t (:foreground ,schwilk-red))))
   `(nav-face-file ((t (:foreground ,schwilk-fg))))
   `(nav-face-hfile ((t (:foreground ,schwilk-red-4))))
;;;;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,schwilk-blue :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,schwilk-green+2 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,schwilk-blue-2 :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,schwilk-green :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,schwilk-blue-4 :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,schwilk-green-1 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,schwilk-blue :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,schwilk-bg+3))))
   `(mu4e-trashed-face ((t (:foreground ,schwilk-bg+3 :strike-through t))))
;;;;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,schwilk-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,schwilk-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,schwilk-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,schwilk-bg+1))))
;;;;; org-mode
   `(org-agenda-date-today
     ((t (:foreground "white" :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,schwilk-fg :weight bold))))
   `(org-checkbox ((t (:background ,schwilk-bg+2 :foreground "white"
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,schwilk-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,schwilk-red-1))))
   `(org-done ((t (:bold t :weight bold :foreground ,schwilk-green+3))))
   `(org-formula ((t (:foreground ,schwilk-yellow-2))))
   `(org-headline-done ((t (:foreground ,schwilk-green+3))))
   `(org-hide ((t (:foreground ,schwilk-bg+1))))  ;; Note: org mode overwrites this on load for some reason
   `(org-level-1 ((t (:foreground ,schwilk-orange))))
   `(org-level-2 ((t (:foreground ,schwilk-yellow))))
   `(org-level-3 ((t (:foreground ,schwilk-green+4))))
   `(org-level-4 ((t (:foreground ,schwilk-yellow-1))))
   `(org-level-5 ((t (:foreground ,schwilk-blue+1))))
   `(org-level-6 ((t (:foreground ,schwilk-green+2))))
   `(org-level-7 ((t (:foreground ,schwilk-blue-1))))
   `(org-level-8 ((t (:foreground ,schwilk-green-1))))
   `(org-link ((t (:foreground ,schwilk-yellow-2 :underline t))))
   `(org-scheduled ((t (:foreground ,schwilk-green+4))))
   `(org-scheduled-previously ((t (:foreground ,schwilk-red-4))))
   `(org-scheduled-today ((t (:foreground ,schwilk-blue+1))))
   `(org-special-keyword ((t (:foreground ,schwilk-fg-1 :weight normal))))
   `(org-table ((t (:foreground ,schwilk-green+2))))
   `(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,schwilk-orange))))
   `(org-todo ((t (:bold t :foreground ,schwilk-red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:inherit warning))))
   `(org-column ((t (:background ,schwilk-bg-1))))
   `(org-column-title ((t (:background ,schwilk-bg-1 :underline t :weight bold))))
;;;;; outline
   `(outline-1 ((t (:foreground ,schwilk-orange))))
   `(outline-2 ((t (:foreground ,schwilk-green+4))))
   `(outline-3 ((t (:foreground ,schwilk-blue-1))))
   `(outline-4 ((t (:foreground ,schwilk-yellow-2))))
   `(outline-5 ((t (:foreground ,schwilk-cyan))))
   `(outline-6 ((t (:foreground ,schwilk-green+2))))
   `(outline-7 ((t (:foreground ,schwilk-red-2))))
   `(outline-8 ((t (:foreground ,schwilk-blue-4))))
;;;;; python
   `(py-builtins-face ((t (:bold t :foreground ,schwilk-blue-1))))
   `(py-pseudo-keyword-face ((t (:bold t :foreground ,schwilk-blue-2))))

;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,schwilk-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,schwilk-green+2))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,schwilk-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,schwilk-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,schwilk-green-1))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,schwilk-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,schwilk-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,schwilk-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,schwilk-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,schwilk-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,schwilk-green))))
   `( rainbow-delimiters-depth-12-face ((t (:foreground ,schwilk-blue-5))))
;;;;; rcirc
   `(rcirc-my-nick ((t (:foreground ,schwilk-blue))))
   `(rcirc-other-nick ((t (:foreground ,schwilk-orange))))
   `(rcirc-bright-nick ((t (:foreground ,schwilk-blue+1))))
   `(rcirc-dim-nick ((t (:foreground ,schwilk-blue-2))))
   `(rcirc-server ((t (:foreground ,schwilk-green))))
   `(rcirc-server-prefix ((t (:foreground ,schwilk-green+1))))
   `(rcirc-timestamp ((t (:foreground ,schwilk-green+2))))
   `(rcirc-nick-in-message ((t (:foreground ,schwilk-yellow))))
   `(rcirc-nick-in-message-full-line ((t (:bold t))))
   `(rcirc-prompt ((t (:foreground ,schwilk-yellow :bold t))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:bold t))))
   `(rcirc-url ((t (:bold t))))
   `(rcirc-keyword ((t (:foreground ,schwilk-yellow :bold t))))
;;;;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,schwilk-green))))
   `(rpm-spec-doc-face ((t (:foreground ,schwilk-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,schwilk-red))))
   `(rpm-spec-macro-face ((t (:foreground ,schwilk-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,schwilk-red))))
   `(rpm-spec-package-face ((t (:foreground ,schwilk-red))))
   `(rpm-spec-section-face ((t (:foreground ,schwilk-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,schwilk-blue))))
   `(rpm-spec-var-face ((t (:foreground ,schwilk-red))))
;;;;; rst-mode
   `(rst-level-1-face ((t (:foreground ,schwilk-orange))))
   `(rst-level-2-face ((t (:foreground ,schwilk-yellow))))
   `(rst-level-3-face ((t (:foreground ,schwilk-green+4))))
   `(rst-level-4-face ((t (:foreground ,schwilk-blue-1))))
   `(rst-level-5-face ((t (:foreground ,schwilk-yellow-2))))
   `(rst-level-6-face ((t (:foreground ,schwilk-cyan))))
;;;;; show-paren
   `(show-paren-mismatch ((t (:foreground ,schwilk-red-3 :background ,schwilk-bg :weight bold))))
   `(show-paren-match ((t (:foreground ,schwilk-blue-1 :background ,schwilk-bg :weight bold))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-inputed-output-face ((t (:foreground ,schwilk-red))))
;;;;; tabbar
   `(tabbar-button ((t (:foreground ,schwilk-fg
                                    :background ,schwilk-bg))))
   `(tabbar-selected ((t (:foreground ,schwilk-fg
                                      :background ,schwilk-bg
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,schwilk-fg
                                        :background ,schwilk-bg+1
                                        :box (:line-width -1 :style released-button)))))
;;;;; term
   `(term-color-black ((t (:foreground ,schwilk-bg
                                       :background ,schwilk-bg-1))))
   `(term-color-red ((t (:foreground ,schwilk-red-2
                                       :background ,schwilk-red-4))))
   `(term-color-green ((t (:foreground ,schwilk-green
                                       :background ,schwilk-green+2))))
   `(term-color-yellow ((t (:foreground ,schwilk-orange
                                       :background ,schwilk-yellow))))
   `(term-color-blue ((t (:foreground ,schwilk-blue-1
                                      :background ,schwilk-blue-4))))
   `(term-color-magenta ((t (:foreground ,schwilk-magenta
                                         :background ,schwilk-red))))
   `(term-color-cyan ((t (:foreground ,schwilk-cyan
                                       :background ,schwilk-blue))))
   `(term-color-white ((t (:foreground ,schwilk-fg
                                       :background ,schwilk-fg-1))))
   '(term-default-fg-color ((t (:inherit term-color-white))))
   '(term-default-bg-color ((t (:inherit term-color-black))))
;;;;; volatile-highlights
   `(vhl/default-face ((t (:background ,schwilk-bg-05))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,schwilk-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,schwilk-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,schwilk-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,schwilk-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,schwilk-green+2 :background ,schwilk-bg))))
   `(w3m-lnum-match ((t (:background ,schwilk-bg-1
                                     :foreground ,schwilk-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,schwilk-yellow))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,schwilk-bg+1 :foreground ,schwilk-bg+1))))
   `(whitespace-hspace ((t (:background ,schwilk-bg+1 :foreground ,schwilk-bg+1))))
   `(whitespace-tab ((t (:background ,schwilk-red-1))))
   `(whitespace-newline ((t (:foreground ,schwilk-bg+1))))
   `(whitespace-trailing ((t (:background ,schwilk-red))))
   `(whitespace-line ((t (:background ,schwilk-bg :foreground ,schwilk-magenta))))
   `(whitespace-space-before-tab ((t (:background ,schwilk-orange :foreground ,schwilk-orange))))
   `(whitespace-indentation ((t (:background ,schwilk-yellow :foreground ,schwilk-red))))
   `(whitespace-empty ((t (:background ,schwilk-yellow))))
   `(whitespace-space-after-tab ((t (:background ,schwilk-yellow :foreground ,schwilk-red))))
;;;;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,schwilk-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,schwilk-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,schwilk-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,schwilk-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,schwilk-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,schwilk-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,schwilk-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,schwilk-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,schwilk-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,schwilk-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,schwilk-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,schwilk-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,schwilk-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,schwilk-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,schwilk-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,schwilk-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,schwilk-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,schwilk-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,schwilk-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,schwilk-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,schwilk-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,schwilk-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,schwilk-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,schwilk-magenta))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,schwilk-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,schwilk-green+4))))
;;;;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,schwilk-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,schwilk-bg-1 :foreground ,schwilk-bg-1))))
   ))

;;; Theme Variables
(schwilk-with-color-variables
  (custom-theme-set-variables
   'schwilk
;;;;; ansi-color
   `(ansi-color-names-vector [,schwilk-bg ,schwilk-red ,schwilk-green ,schwilk-yellow
                                          ,schwilk-blue ,schwilk-magenta ,schwilk-cyan ,schwilk-fg])
;;;;; fill-column-indicator
   `(fci-rule-color ,schwilk-bg-05)
;;;;; vc-annotate
   `(vc-annotate-color-map
     '(( 20. . ,schwilk-red-1)
       ( 40. . ,schwilk-red)
       ( 60. . ,schwilk-orange)
       ( 80. . ,schwilk-yellow-2)
       (100. . ,schwilk-yellow-1)
       (120. . ,schwilk-yellow)
       (140. . ,schwilk-green-1)
       (160. . ,schwilk-green)
       (180. . ,schwilk-green+1)
       (200. . ,schwilk-green+2)
       (220. . ,schwilk-green+3)
       (240. . ,schwilk-green+4)
       (260. . ,schwilk-cyan)
       (280. . ,schwilk-blue-2)
       (300. . ,schwilk-blue-1)
       (320. . ,schwilk-blue)
       (340. . ,schwilk-blue+1)
       (360. . ,schwilk-magenta)))
   `(vc-annotate-very-old-color ,schwilk-magenta)
   `(vc-annotate-background ,schwilk-bg-1)
   ))

;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defvar schwilk-add-font-lock-keywords nil
  "Whether to add font-lock keywords for schwilk color names.
In buffers visiting library `schwilk-theme.el' the schwilk
specific keywords are always added. In all other Emacs-Lisp
buffers this variable controls whether this should be done.
This requires library `rainbow-mode'.")

(defvar schwilk-colors-font-lock-keywords nil)

;; (defadvice rainbow-turn-on (after schwilk activate)
;; "Maybe also add font-lock keywords for schwilk colors."
;; (when (and (derived-mode-p 'emacs-lisp-mode)
;; (or schwilk-add-font-lock-keywords
;; (equal (file-name-nondirectory (buffer-file-name))
;; "schwilk-theme.el")))
;; (unless schwilk-colors-font-lock-keywords
;; (setq schwilk-colors-font-lock-keywords
;; `((,(regexp-opt (mapcar 'car schwilk-colors-alist) 'words)
;; (0 (rainbow-colorize-by-assoc schwilk-colors-alist))))))
;; (font-lock-add-keywords nil schwilk-colors-font-lock-keywords)))

;; (defadvice rainbow-turn-off (after schwilk activate)
;; "Also remove font-lock keywords for schwilk colors."
;; (font-lock-remove-keywords nil schwilk-colors-font-lock-keywords))

;;; Footer

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'schwilk)

;;;###autoload
(add-to-list 'safe-local-eval-forms
             '(when (require 'rainbow-mode nil t) (rainbow-mode 1)))

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; schwilk-theme.el ends here
