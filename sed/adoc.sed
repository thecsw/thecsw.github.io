# Adjusting headers, because pandoc adds 1 additional level,
# we get rid of the first equal sign
s/^=//

# Add the top card with some links and my email
1 a Sagindyk Urazayev <ctu@ku.edu>\nAbout_LINK | Bookshelf_LINK | Fortunes_LINK | Home_LINK\n:toc: left\n:toc-title: Table of Adventures ⛵\n:nofooter:\n:experimental:

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

# Covert the picture macros into asciidoctor
s|PICTURE ([^<>]+):([^<>:]+):([0-9]+):([a-z]+)|.\2\nimage::\1[\2, width=\3, role="\4", link="\1"]|
s|PIC ([^<>]+):([^<>]+)|.\2\nimage::\1[\2, link="\1"]|

# Fix the youtube links
s|YOUTUBE~|YOUTUBE|g
s|([^~/ ])~([^~ ])|\1_\2|g
