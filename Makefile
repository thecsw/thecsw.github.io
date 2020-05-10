# Make the build silent by default
V =

# Some shell magic
ifeq ($(strip $(V)),)
	E = @echo
	Q = @
else
	E = @\#
	Q =
endif
export E Q

COMPILER = asciidoctor-latex -b html
FLAGS = -a toc
# Emptying the flags because we don't want
# to have TOC on the front page, be lazy
FLAGS = 
NAME = mywebsite
ORIGINAL_TYPE = org
INPUT_TYPE = adoc
OUTPUT_TYPE = html
NAME = Sagindyk Urazayev
EMAIL = ctu@ku.edu
ATTRS=:toc: left\n:toc-title: Table of Adventures ⛵\n:nofooter:\n:experimental:
VCARD = $(NAME) <$(EMAIL)>\nAbout_LINK | GitHub_LINK | LinkedIn_LINK | Keybase_LINK | Home_LINK\n$(ATTRS)
LINKEDIN = https://www.linkedin.com/in/thecsw/
GITHUB = https://github.com/thecsw
ABOUT = /about
RESUME = /resume
KEYBASE = https://keybase.io/thecsw
GPG_KEY = https://pgp.key-server.io/pks/lookup?op=vindex\&search=0xCCE2E27DAC465AC163013F1161BB674C628BB45B
FONT = Inter
FONT_CODE = DejaVu Sans Mono

INPUT_FILES = find . -type f -name '*$(INPUT_TYPE)'
OUTPUT_FILES = find . -type f -name "*$(OUTPUT_TYPE)" | sort | diff - $(sort exclude.txt) | grep '<' | sed -E "s/< (.+)/\1/"

$(NAME):
	$(Q) notify-send "Sandy's Website" "building..."
	$(E) "	CONVERTING ORG TO ADOC ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' | sed -E 's|(.+)\.$(ORIGINAL_TYPE)$$|pandoc -i \1.$(ORIGINAL_TYPE) -o \1.$(INPUT_TYPE)|g' | sh
	$(E) "	MAKING README ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' | sed -E 's|(.+)/[^/]+\.$(ORIGINAL_TYPE)$$|pandoc -i \1/index.$(ORIGINAL_TYPE) -o \1/README.md|g' | sh
	$(Q) find . -type f -name "README.md" | xargs sed "1 i ![preview](./preview.png)" -i
	$(E) "	ADJUSTING HEADERS ..."
	$(Q) $(INPUT_FILES) | xargs sed 's/^=//g' -i 
	$(E) "	ADDING VCARD ..."
	$(Q) $(INPUT_FILES) | xargs sed '1 a $(VCARD)' -i
	$(E) "	ADJUSTING THE HOMEPAGE ..."
	$(Q) find . -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs sed 's/| Home_LINK//g;/^:/d' -i
	$(E) "	FIXING ARTIFACTS ..."
	$(Q) $(INPUT_FILES) | xargs sed -E 's/~(.+)~/_\1/g' -i
	$(E) "	ADDING ABSTRACTS ..."
	$(Q) $(INPUT_FILES) | xargs sed -E 's/== Abstract/[abstract]\n.Abstract\n/g' -i
	$(E) "	UPDATING MATH FORMULAS ..."
	$(Q) $(INPUT_FILES) | xargs sed -E 's/^PROOF/[latexmath]\n++++\n\\underline{Proof}\n++++\n/g' -i
	$(Q) $(INPUT_FILES) | xargs sed -E 's/^THEOREM/[latexmath]\n++++\n\\underline{Theorem}\n++++\n/g' -i
	$(Q) $(INPUT_FILES) | xargs sed -E 's=\\]$$==g;s=^\\\[==g;' -i
	$(Q) $(INPUT_FILES) | xargs sed -E 's=latexmath:\[==g;s=[$$]]=$$=g' -i
	$(E) "	ADDING PICTURES"
	$(Q) $(INPUT_FILES) | xargs sed -E 's|PICTURE ([^<>]+):([^<>]+):([0-9]+):([a-z]+)|.\2\nimage::\1[\2, width=\3, role="\4", link="\1"]|g;' -i
	$(Q) $(INPUT_FILES) | xargs sed -E 's|PIC ([^<>]+):([^<>]+)|.\2\nimage::\1[\2, link="\1"]|g;' -i
	$(E) "	BUILDING ..."
	$(Q) $(INPUT_FILES) | xargs $(COMPILER) $(FLAGS) 2>/dev/null
	$(E) "	SETTING LINKEDIN ..."
	$(Q) $(OUTPUT_FILES) | xargs sed 's|LinkedIn_LINK|<a href="$(LINKEDIN)">LinkedIn 🕴</a>|g' -i
	$(E) "	SETTING GITHUB ..."
	$(Q) $(OUTPUT_FILES) | xargs sed 's|GitHub_LINK|<a href="$(GITHUB)">GitHub 🐙</a>|g' -i
	$(E) "	SETTING ABOUT ..."
	$(Q) $(OUTPUT_FILES) | xargs sed 's|About_LINK|<a href="$(ABOUT)">About 🤔</a>|g' -i
	$(E) "	SETTING KEYBASE ..."
	$(Q) $(OUTPUT_FILES) | xargs sed 's|Keybase_LINK|<a href="$(KEYBASE)">Keybase 💆</a>|g' -i
	$(E) "	SETTING HOME ..."
	$(Q) $(OUTPUT_FILES) | xargs sed 's|Home_LINK|<a href="/">Home 🏠</a>|g' -i
	$(E) "	SETTING PREVIEW ..."
	$(Q) $(OUTPUT_FILES) | xargs sed '/<title/i\<meta property="og:image" content="./preview.png">' -i
	$(Q) $(OUTPUT_FILES) | xargs sed '/<title/i\<meta property="og:site_name" content="Sandy&apos;s Website">' -i
	$(Q) $(OUTPUT_FILES) | xargs sed '/<title/i\<meta property="og:type" content="object">' -i
	$(Q) $(OUTPUT_FILES) | xargs sed -E 's|<title>([^<>]+)</title>|<meta property="og:title" content="\1">\n<title>\1</title>|g' -i
	$(Q) $(OUTPUT_FILES) | xargs sed '/<title/i\<meta property="og:description" content="Hey, everyone! This is Sandy. Welcome to my website">' -i
	$(E) "	SETTING FAVICON ..."
	$(Q) $(OUTPUT_FILES) | xargs sed '/<title/i\<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>' -i
	$(E) "	SETTING SCRIPTS ..."
#	$(Q) $(OUTPUT_FILES) | xargs sed 's|</title>|</title>\n</style><script src="snowstorm-min.js"></script>|g' -i
	$(E) "	FIXING RESUME REDIRECT ..."
	$(Q) find ./resume -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|&lt;|<|g;s|&gt;|>|g;' -i
	$(E) "	UPDATING FONTS ..."
	$(Q) $(OUTPUT_FILES) | xargs sed '/<link rel="stylesheet" href="https:\/\/fonts.googleapis.com/d' -i
	$(Q) $(OUTPUT_FILES) | xargs sed 's|Noto Serif|$(FONT)|g;s|Open|$(FONT)|g;s|DejaVu|$(FONT)|g;s|Droid Sans Mono|$(FONT_CODE)|g;' -i
	$(E) "	UPDATING STYLES ..."
	$(Q) $(OUTPUT_FILES) | xargs sed '/<body/i\<link rel="stylesheet" type="text/css" href="/styles/web.min.css">' -i
	$(E) "	UPDATING AUDIO ..."
	$(Q) $(OUTPUT_FILES) | xargs sed -E 's|PLAY_SONG ([^<>]+)|<audio controls><source src="\1" type="audio/mpeg">bruh moment</audio>|g;' -i
	$(E) "	UPDATING YOUTUBE ..."
	$(Q) $(OUTPUT_FILES) | xargs sed -E 's|PLAY_YOUTUBE ([^<>]+)|<iframe width="420" height="256" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>|g;' -i
	$(E) "	ADDING GISTS"
	$(Q) $(OUTPUT_FILES) | xargs sed -E 's|GIST ([^<>]+)|<script src="https://gist.github.com/\1.js"></script>|g;' -i
	$(Q) notify-send "Sandy's Website" "Build complete!"
