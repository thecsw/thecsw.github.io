# Adjusting headers, because pandoc adds 1 additional level,
# we get rid of the first equal sign
s/^=//

# Add the top card with some links and my email
1 a email <ctu [at] ku [dot] edu>\nAbout_LINK | Bookshelf_LINK | Fortunes_LINK | Home_LINK\n:toc: preamble\n:toclevels: 4\n:toc-title: Table of Adventures ⛵\n:nofooter:\n:experimental:\n:!figure-caption:

# Fix some weird org->adoc stuff when underscore becomes a tilda
s/~(.+)~/_\1/

# Make abstract section behave like an asciidoctor abstract
s/== Abstract/[abstract]\n.Abstract\n/

# Mathjax formatting
s/^PROOF/[latexmath]\n++++\n\\underline{Proof}\n++++\n/
s/^THEOREM/[latexmath]\n++++\n\\underline{Theorem}\n++++\n/

# I don't know
s=\\]$$==g
s=^\\\[==
s=latexmath:\[==g
s=[$$]]=$=g

# Fix the youtube links
s|YOUTUBE~|YOUTUBE|g
s|([^~/ ])~([^~ ])|\1_\2|g

# Covert the picture macros into asciidoctor and wrap it in horizontal lines
s|PICTURE ([^<>]+):([^<>:]+):([0-9]+):([a-z]+)|HORLINE\n.\2\nimage::\1[\2, width=\3, role="\4", link="\1"]\nHORLINE|g
s|PIC ([^<>]+)::([^<>]+)|HORLINE\n.\2\nimage::\1[\2, link="\1"]\nHORLINE|g
s|HORLINE|++++\n<hr>\n++++|g

# Add an audio file
s|SONG ([^<>]+)|++++\n<audio controls><source src="\1" type="audio/mpeg">bruh moment</audio>\n++++|g

# Add a spotify player
s|SPOTIFY ([^<>]+)|++++\n<iframe src="https://open.spotify.com/embed/track/\1" width="79%" height="80" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>\n++++|g

# Add a spotify playlist player
s|SPOTIFYPLAYLIST ([^<>]+)|++++\n<iframe src="https://open.spotify.com/embed/playlist/\1" width="79%" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>\n++++|g

# Add a youtube embed
s|YOUTUBE ([^<>]+)|++++\n<iframe width="100%" height="330px" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>\n++++|g

# Add a github gist 
s|GIST ([^<>]+)|++++\n<script src="https://gist.github.com/\1.js"></script>\n++++|g

# Add the mathjax script for loading math
s|USEMATHJAX|++++\n<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script><script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>\n++++|g
