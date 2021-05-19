# Put the links in the header section
s|About_LINK|<a href="/about">About 🤔</a>|
s|Bookshelf_LINK|<a href="/books">Bookshelf 📖</a>|
s|Fortunes_LINK|<a href="/fortunes">Fortunes 🥠</a>|
s|Home_LINK|<a href="/">Home 🏠</a>|
s|Time_LINK|<p id="time"></p>|

s|<h1>|<h1><img id="myface" src="/small.png" width="80">|

# Each page should have a preview image
/<title/i\<meta property="og:image" content="./preview.png">
/<title/i\<meta property="og:image:alt" content="Preview">

# Add the website's favicon
/<title/i\<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
/<title/i\<link rel="icon" href="/favicon.ico">

# Define the website's main color scheme for some browsers
/<title/i\<meta name="theme-color" content="#FFFFF4">

# This is website's name
/<title/i\<meta property="og:site_name" content="Sandy&apos;s Website">

# Some more Open Graph properties about what each webpage is
/<title/i\<meta property="og:locale" content="en_GB">
/<title/i\<meta property="og:type" content="website">

# Extract the value from title tag and put it into title meta property
s|<title>([^<>]+)</title>|<meta property="og:title" content="\1">\n<title>\1</title>|g

# Site description is set in the makefile by sh/og_desc.sh
#/<title/i\<meta property="og:description" content="Hey, everyone! This is Sandy. Welcome">

# Cut the mustard: https://fettblog.eu/cutting-the-mustard-2018/
# Taken from: https://www.matuzo.at/blog/html-boilerplate/
/<title/i\<script type="module">document.documentElement.classList.remove("no-js");document.documentElement.classList.add("js");</script>

# Add the mathjax script for loading math
s|USEMATHJAX|<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML"></script>|g

# Make the MathJax script work, some edgecases while converting
s=\$([^$]+)\$=\\(\1\\)=g
s=<sup>=^=g

# Add the foundation time script
/<title/i\<script async src="/scripts/time.js"></script>

# Add scripts, like snow effect
#s|</title>|</title>\n</style><script src="snowstorm-min.js"></script>|g

# Use the google fonts to get Inter
/<link rel="stylesheet" href="https:\/\/fonts.googleapis.com/d

# Modify default fonts
s|Noto Serif|Inter|g
s|Open|Inter|g
s|DejaVu|Inter|g
s|Droid Sans Mono|DejaVu Sans Mono|g

# Import some CSS adjustments
/<body/i\<link rel="stylesheet" type="text/css" href="https://sandyuraz.com/styles/web.min.css">

# Run media macros
s|PLAY_SONG ([^<>]+)|<audio controls><source src="\1" type="audio/mpeg">bruh moment</audio>|
s|PLAY_SPOTIFY ([^<>]+)|<iframe src="https://open.spotify.com/embed/track/\1" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>|
s|PLAY_YOUTUBE ([^<>]+)|<iframe width="420" height="256" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>|
s|GIST ([^<>]+)|<script src="https://gist.github.com/\1.js"></script>|

# Add the HE time div section to print out the Foundation-style time
448i<div id="hetime" class="details"></div>
