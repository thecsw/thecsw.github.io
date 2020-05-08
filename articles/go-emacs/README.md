Becoming an emacs gopher 🐗
==========================

May 7th, 2020

I have been a full-time emacs user for the past 4 years and I have been
working in Golang professionally for about 2 years now. Combining those
two beauties is quite a task with so many different modules and addons
available. I believe I found an example of a modular and a comfortable
setup. *Demo below!*

Getting dependencies
--------------------

One of many great things about Go is its tooling environment. You can
write any tools and implement your ideas with ease.

First tool you need is usually [Go itself](https://golang.org/). After
that, install some of the go tools dependencies below:

``` {.bash org-language="sh"}
% go get -u golang.org/x/tools/cmd/goimports
% go get -u github.com/rogpeppe/godef
% go get -u github.com/nsf/gocode
```

Next we need to install some of the emacs dependencies through
[MELPA](https://melpa.org). This is gonna be big, prep your `.emacs.d`
for some fun time compiling elisp. Refresh your local repo of packages
by running kbd:\[M-x package-refresh-contents\]. You can install
packages by running kbd:\[M-x package-install PACKAGE-NAME\]

Here is the list:

-   [auto-complete](https://github.com/auto-complete/auto-complete) - An
    Intelligent auto-completion extension for Emacs
-   [go-mode](https://github.com/dominikh/go-mode.el) - Emacs mode for
    the Go programming language
-   [go-complete](https://github.com/vibhavp/go-complete) - Native Go
    completion for Emacs
-   [go-autocomplete](https://melpa.org/#/go-autocomplete) -
    auto-complete-mode backend for go-mode
-   [autopair](https://github.com/capitaomorte/autopair) - Automagically
    pair braces and quotes in emacs like TextMate

Config
------

You can just put this in your `.emacs` or whatever init file you\'re
using. The following config is all you need to get yourself started with
automatic code formatting, code completion, parenthesis matching, dot
completion (!), and jump to definition.

``` {.commonlisp org-language="emacs-lisp"}
;; Init the auto complete modules
(ac-config-default)
(global-auto-complete-mode t)
(require 'go-autocomplete)

;; Enable auto-complete
(auto-complete-mode 1)

;; Define keymaps
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd"C-c C-c") 'godef-jump)

;; Set some quick config vals
(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.8)

;; Just to make sure go tools are enabled
(add-to-list 'exec-path "~/go/bin")

;; Automatically format code on save
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'auto-complete-for-go)
```

After that, just reload your emacs and you should have full go
environment installed!

Demo
----

.Gopher in emacs

image::demo.svg\[demo.svg, role=\"center\", link=\"./demo.svg\"\]
