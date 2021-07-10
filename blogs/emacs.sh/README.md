![preview](./preview.png)
Getting Sandy\'s .emacs.d 🤺
===========================

212; 12020 H.E.

After years of carefully cultivating and taking care of my `.emacs.d`
config files, I thought it may be time to try and share it, maybe
someone will like it

I host my `.emacs.d` on [github](https://github.com/thecsw/.emacs.d),
however, it depends on some LSP quirks and go tools that I decided
writing a quick shell script to do the work. You can visit the config\'s
webpage [here](https://sandyuraz.com/.emacs.d).

All you have to run is the curl command below in your home directory
(`_`)

NOTE: existing installation will move to .bak append

``` {.bash org-language="sh"}
curl -fsSL https://raw.githubusercontent.com/thecsw/thecsw.github.io/master/sh/emacs.sh | sh
```

It will clone `.emacs.d`, symlink `.emacs`, and optionally install
golang X tools (considering you have Go installed)

Read more on [getting an emacs server running](../emacsd) (better use
emacs-lsp now)
