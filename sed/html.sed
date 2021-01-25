# Put the links in the header section
s|About_LINK|<a href="/about">About 🤔</a>|
s|Bookshelf_LINK|<a href="/books">Bookshelf 📖</a>|
s|Fortunes_LINK|<a href="/fortunes">Fortunes 🥠</a>|
s|Home_LINK|<a href="/">Home 🏠</a>|
s|Time_LINK|<p id="time"></p>|

# Add all the meta properties
/<title/i\<meta property="og:image" content="./preview.png">
/<title/i\<meta property="og:site_name" content="Sandy&apos;s Website">
/<title/i\<meta property="og:type" content="object">
s|<title>([^<>]+)</title>|<meta property="og:title" content="\1">\n<title>\1</title>|g
/<title/i\<meta property="og:description" content="Hey, everyone! This is Sandy. Welcome to my website">
/<title/i\<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
/<title/i\<script id="MathJax-script" async src="/scripts/mathjax/tex-mml-svg.js"></script>
/<title/i\<script async src="/scripts/time.js"></script>

# Make the MathJax script
s=\$([^$]+)\$=\\(\1\\)=g
s=<sup>=^=g
s=</sup>=^=g

# Remove the extra ^ when doing citations
s=]^=]=g

# Add scripts, like snow effoct
#s|</title>|</title>\n</style><script src="snowstorm-min.js"></script>|g

# Use the google fonts to get Inter
/<link rel="stylesheet" href="https:\/\/fonts.googleapis.com/d

# Modify default fonts
s|Noto Serif|Inter|g
s|Open|Inter|g
s|DejaVu|Inter|g
s|Droid Sans Mono|DejaVu Sans Mono|g

# Import some CSS adjustments
/<body/i\<link rel="stylesheet" type="text/css" href="/styles/web.min.css">

# Run media macros
s|PLAY_SONG ([^<>]+)|<audio controls><source src="\1" type="audio/mpeg">bruh moment</audio>|
s|PLAY_SPOTIFY ([^<>]+)|<iframe src="https://open.spotify.com/embed/track/\1" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>|
s|PLAY_YOUTUBE ([^<>]+)|<iframe width="420" height="256" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>|
s|GIST ([^<>]+)|<script src="https://gist.github.com/\1.js"></script>|

# Add the HE time
450i<div id="hetime" class="details"></div>
