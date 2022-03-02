# Put the links in the header section
s|About_LINK|<a href="/about">About 🤔</a>|
s|Bookshelf_LINK|<a href="/books">Bookshelf 📖</a>|
s|Fortunes_LINK|<a href="/fortunes">Fortunes 🥠</a>|
s|Home_LINK|<a href="/">Home 🏠</a>|
s|Time_LINK|<p id="time"></p>|

s|<h1>|<h1><img id="myface" src="/small.png" width="100">|

/<title/i\<link rel="canonical" href="URLPATH">

# Each page should have a preview image
/<title/i\<meta property="og:image" content="PREVIEWPATH">
/<title/i\<meta property="og:image:alt" content="Preview">
/<title/i\<meta property="og:image:type" content="image/png">
/<title/i\<meta property="og:image:width" content="1280">
/<title/i\<meta property="og:image:height" content="640">


# Add the website's favicon
/<title/i\<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
/<title/i\<link rel="icon" href="/favicon.ico">

# This is website's name
/<title/i\<meta property="og:site_name" content="Sandy&apos;s Website">
/<title/i\<meta property="og:url" content="URLPATH">

# Some more Open Graph properties about what each webpage is
/<title/i\<meta property="og:locale" content="en_GB">
/<title/i\<meta property="og:type" content="website">

# Add fancy looking tab colors like on Safari 15
/<title/i\<meta name="theme-color" content="#fffff4">

# Extract the value from title tag and put it into title meta property
s|<title>([^<>]+)</title>|<meta property="og:title" content="\1">\n<title>\1</title>|g

# Add Twitter OpenGraph
/<title/i\<meta name="twitter:card" content="summary_large_image">
/<title/i\<meta property="twitter:site" content="Sandy&apos;s Website">
/<title/i\<meta property="twitter:creator" content="@sandyuraz">
/<title/i\<meta property="twitter:image:src" content="PREVIEWPATH">
s|<title>([^<>]+)</title>|<meta property="twitter:title" content="\1">\n<title>\1</title>|g
/<title/i\<meta property="twitter:url" content="URLPATH">

# Site description is set in the makefile by sh/og_desc.sh
#/<title/i\<meta property="og:description" content="Hey, everyone! This is Sandy. Welcome">

# Cut the mustard: https://fettblog.eu/cutting-the-mustard-2018/
# Taken from: https://www.matuzo.at/blog/html-boilerplate/
/<title/i\<script type="module">document.documentElement.classList.remove("no-js");document.documentElement.classList.add("js");</script>

# Make the MathJax script work, some edgecases while converting
s=\$([^$]+)\$=\\(\1\\)=g
s=<sup>=^=g

# Add the foundation time script
/<title/i\<script async src="/scripts/time.js"></script>

# Add scripts, like snow effect
#s|</title>|</title>\n</style><script src="snowstorm-min.js"></script>|g

# Use the google fonts to get Lora
/<link rel="stylesheet" href="https:\/\/fonts.googleapis.com/d

# Modify default fonts
s|Noto Serif|Lora|g
s|Open|Lora|g
s|DejaVu|Lora|g
s|Droid Sans Mono|DejaVu Sans Mono|g

# Import some CSS adjustments
/<body/i\<link rel="stylesheet" type="text/css" href="https://sandyuraz.com/css/asciidoctor.css">
/<body/i\<link rel="stylesheet" type="text/css" href="https://sandyuraz.com/css/web.css">

# Add the HE time div section to print out the Foundation-style time
448i<div id="hetime" class="details"></div>
