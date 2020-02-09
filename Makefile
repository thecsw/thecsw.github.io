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

COMPILER = asciidoctor
FLAGS = -a toc
FLAGS = 
NAME = mywebsite
ORIGINAL_TYPE = org
INPUT_TYPE = adoc
OUTPUT_TYPE = html
NAME = Sagindyk Urazayev
EMAIL = ctu@ku.edu
VCARD = $(NAME) <$(EMAIL)>\nLinkedIn_LINK | GitHub_LINK | Resume_LINK | PGP Key_LINK | Home_LINK\n:toc: left\n:toc-title: Table of Adventures ⛵
LINKEDIN = https://www.linkedin.com/in/thecsw/
GITHUB = https://github.com/thecsw
RESUME = /resume
GPG_KEY = https://pgp.key-server.io/pks/lookup?op=vindex\&search=0xCCE2E27DAC465AC163013F1161BB674C628BB45B
FONT = Inter
FONT_CODE = Iosevka

$(NAME):
	$(E) "	CONVERTING ORG TO ADOC ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' | sed -E 's|(.+)\.$(ORIGINAL_TYPE)$$|pandoc -i \1.$(ORIGINAL_TYPE) -o \1.$(INPUT_TYPE)|g' | sh
	$(E) "	ADJUSTING HEADERS ..."
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs sed 's/^=//g' -i 
	$(E) "	ADDING VCARD ..."
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs sed '1 a $(VCARD)' -i
	$(E) "	ADJUSTING THE HOMEPAGE ..."
	$(Q) find . -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs sed 's/| Home_LINK//g;/^:/d' -i
	$(E) "	FIXING ARTIFACTS ..."
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs sed -E 's/~(.+)~/_\1/g' -i
	$(E) "	ADDING ABSTRACTS ..."
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs sed -E 's/== Abstract/[abstract]\n.Abstract\n/g' -i 
	$(E) "	BUILDING ..."
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs $(COMPILER) $(FLAGS)
	$(E) "	SETTING LINKEDIN ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|LinkedIn_LINK|<a href="$(LINKEDIN)">LinkedIn 🕴</a>|g' -i
	$(E) "	SETTING GITHUB ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|GitHub_LINK|<a href="$(GITHUB)">GitHub 🐙</a>|g' -i
	$(E) "	SETTING RESUME ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|Resume_LINK|<a href="$(RESUME)">Resume 📋</a>|g' -i
	$(E) "	SETTING PGP KEYS ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|PGP Key_LINK|<a href="$(GPG_KEY)">PGP Key 🔑</a>|g' -i
	$(E) "	SETTING HOME ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|Home_LINK|<a href="/">Home 🏠</a>|g' -i
	$(E) "	SETTING PREVIEW ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|</title>|</title>\n<meta property="og:image" content="preview.png">\n|g' -i
	$(E) "	SETTING FAVICON ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|</title>|</title>\n<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>|g' -i
	$(E) "	SETTING SCRIPTS ..."
#	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|</title>|</title>\n</style><script src="snowstorm-min.js"></script>|g' -i
	$(E) "	FIXING RESUME REDIRECT ..."
	$(Q) find ./resume -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|&lt;|<|g;s|&gt;|>|g;' -i
	$(E) "	UPDATING FONTS ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|Noto Serif|$(FONT)|g;s|Open|$(FONT)|g;s|DejaVu|$(FONT)|g;s|Droid Sans Mono|$(FONT_CODE)|g;' -i
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed 's|</title>|</title>\n<link rel="stylesheet" type="text/css" href="/fonts/fonts.css">|g' -i
	$(E) "	UPDATING AUDIO ..."
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs sed -E 's|PLAY_SONG ([^<>]+)|<audio controls><source src="\1" type="audio/mpeg">bruh moment</audio>|g;' -i

clean:
	$(E) "	CLEANING OUTPUT"
	$(Q) find . -type f -name '*$(OUTPUT_TYPE)' | xargs rm
	$(E) "	CLEANING CONVERTED"
	$(Q) find . -type f -name '*$(INPUT_TYPE)' | xargs rm
