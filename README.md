schwilk-emacs-starter
=====================

A starter .emacs.d directory for my students with support for R programming (through ESS), Markdown editing ([markdown-mode][markdown-mode] and [pandoc-mode][pandoc-mode]), LaTeX editing (auctex), and git (using [magit][magit]). I use [org-mode][org-mode] but for this .emacs, the org-mode setup is just the org-mode defaults. 

There are other good starter packages out there.  There are also some very complete emacs configurations available. One of the best I've seen is [scimax](https://github.com/jkitchin/scimax)

Requirements
------------

This configuration requires Emacs 24. The init.el file will use the Emacs package manager to automatically install any missing required packages.

Installing
----------

### Via git
1. Make your ~/.emacs.d directory if it does not exist
2. clone into it: git clone `https://github.com/schwilklab/emacs-starter.git ~/.emacs.d`

### Via a zipfile
1. use the "Download zip" link at

https://github.com/schwilklab/emacs-starter

2. extract the zip file to your .emacs.d directory

Personalizing
-------------
Modify the placeholders for email address and name in init.el:

    ;; Identification
    (defun user-mail-address() "john.doe@ttu.edu")
    (setq user-full-name "John Doe")

Using
-----

The first time you start emacs with this new configuration, do so as a regular emacs session (not daemon). Emacs will ask you if it is ok to install some packages from MELPA (see list of required packages in init.el). Choose "y" so that emacs will use the package manager to install these packages upon which this configuration depends.

If you receive any errors, close Emacs (from the menu, with "C-x C-c", or "M-x kill-emacs") and restart it. Sometimes it needs a couple of restarts during this package installation phase (I will work on fixing this, it may have to do with the order in which packages are installed).. 

When emacs starts, it may show a gray background theme rather than the dark "schwilk" theme. To load my color theme, go to "options -> Customize Emacs -> Custom themes" and choose "schwilk". Then choose "save" to allow this theme to load automatically from now on. You can use this Customize Emacs menu to select any other installed theme and to change emacs options.  Those settings are then saved to ".emacs.d/custom.el".

### For coding in R and running R interactively

R mode is automatically entered when you edit a file with the extension *.r or *.R. To start the R interpreter highlight a region or put your cursor on
a line of code and hit [shift-enter]. Do the same to send more code to the interpreter. This differs from the standard shortcut key (C-enter) because that key conflcits with CUA-mode. See [emacs speaks statistics][ess] for more details.

### Using git from Emacs

[magit][magit] provides a great interface for git. To bring up the git interface, type "C-x g" when in a window visiting any buffer in a git repository. This calls "magit-status." See the magit documentation for more detail.

### Some departures from emacs defaults

Things to note when you are reading documentation or surfing the web for help. This mode differs from the emacs defaults in these ways

* shift-enter for ess rather than C-enter (to avoid conflict with CUA-mode)
* [cua-mode][cua-mode] Windows style cut-copy-paste (`C-x, C-c, C-v`) enabled
* Uses my dark theme (schwilk-theme) and a custom mode-line (that line of information at the bottom of the frame just above the minibuffer, what is called a "status bar" in other applications). My setup also uses dynamic-fonts to select the font. Currently it chooses monospaced fonts according to this priority list:

    "Inconsolata" "Consolas" "Ubuntu Mono" "Source Code Pro" "Envy Code R" "Droid Sans Mono Pro" "Droid Sans Mono" "DejaVu Sans Mono"
    
Emacs will look for fonts in this order so make sure that at least one is installed. You can change this in lisp/theme.el. I prefer [Inconsolata][inconsolata].

* See lisp/ekeys.el for all keybindings.

### Additional functions

Some keybindings (shortcuts to a few functions in efuncs.el):
* "C-x g"   magit-status
* "C-c \\"  the-the: find duplicated words in your text (spellcheckers usually miss these)
* "C-c d"   insert-date-string: insert a quick date such as 2013-10-22

[cua-mode]:http://www.emacswiki.org/CuaMode
[ess]:http://ess.r-project.org/
[inconsolata]:http://www.levien.com/type/myfonts/inconsolata.html
[magit]:https://github.com/magit/magit
[markdown-mode]:http://jblevins.org/projects/markdown-mode/
[org-mode]:http://orgmode.org/
[pandoc-mode]:http://joostkremers.github.io/pandoc-mode/
