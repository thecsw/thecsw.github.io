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

# Check if notify-send exists
ifeq ($(shell command -v notify-send 2> /dev/null),)
	NOTIFY = @echo 		# if doesn't exist
else
	NOTIFY = @notify-send
endif
export NOTIFY

# Check for gnu version of sed
SED = sed
ifeq ($(shell uname -s), Darwin)
	SED = gsed
endif

COMPILER = asciidoctor -b html
FLAGS = -a toc
# Emptying the flags because we don't want
# to have TOC on the front page, be lazy
FLAGS = 
NAME = mywebsite
ORIGINAL_TYPE = org
INPUT_TYPE = adoc
OUTPUT_TYPE = html

EXCLUDE_ORIGINAL = -not -path "./present/*"
EXCLUDE_OUTPUT = -not -path "./present/*" -and -not -path "./present/*"
INPUT_FILES = find . -type f -name '*$(INPUT_TYPE)'
OUTPUT_FILES = find . -type f -name "*$(OUTPUT_TYPE)" $(EXCLUDE_OUTPUT)

EXCLUDE_TOC = . ./fortunes/ ./blogs/ ./projects/ ./anime/ ./books/

INPUT_SED = ./sed/adoc.sed
README_SED = ./sed/md.sed
OUTPUT_SED = ./sed/html.sed

SCRIPT_DESC = ./sh/og_desc.sh

$(NAME):
	$(Q) $(NOTIFY) "Sandy's Website" "building..."
	$(E) "\n->	CONVERTING ORG TO ADOC ..."
	$(E) "Converting org files into asciidoctor files with pandoc"
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | $(SED) -E 's|(.+)\.$(ORIGINAL_TYPE)$$|pandoc -i \1.$(ORIGINAL_TYPE) -o \1.$(INPUT_TYPE)|g' | sh
	$(E) "\n->	MAKING README ..."
	$(E) "Converting org files into markdown README.md files with pandoc"
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | $(SED) -E 's|(.+)/[^/]+\.$(ORIGINAL_TYPE)$$|pandoc -i \1/index.$(ORIGINAL_TYPE) -o \1/README.md|g' | sh
	$(E) "Inserting README.md markdown previews"
	$(Q) find . -type f -name "README.md" | xargs $(SED) "1 i ![preview](./preview.png)" -i
	$(Q) find . -type f -name "README.md" | xargs $(SED) -E -f $(README_SED) -i
	$(E) "\n->	ADJUSTING ADOC"
	$(E) "Adding some asciidoctor elements and boilerplate"
	$(Q) $(INPUT_FILES) | xargs $(SED) -E -f $(INPUT_SED) -i
	$(E) "Adding tombstone to article posts"
	$(Q) find ./blogs/*/ ./arts/ ./anime/ ./books/ -type f -name '*$(INPUT_TYPE)' | xargs $(SED) "$$ a TOMB" -E -i
	$(E) "\n->	ADJUSTING THE HOMEPAGE ..."
	$(E) "Removing the home link from the root page, because it's already home"
	$(Q) find . -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs $(SED) 's/| Home_LINK//g' -i
	$(E) "Do not show the table of contents on the root page, fortunes page, and the cool stuff page"
	$(Q) find $(EXCLUDE_TOC) -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs $(SED) '/^:toc/d' -i
	$(E) "\n->	BUILDING ..."
	$(E) "Invoking asciidoctor to build the html documents"
	$(Q) $(INPUT_FILES) | xargs $(COMPILER) $(FLAGS) 2>/dev/null
	$(E) "\n->	ADJUSTING HTML"
	$(E) "Adding foundation time element and fixing html"
	$(Q) $(OUTPUT_FILES) | xargs $(SED) -E -f $(OUTPUT_SED) -i
	$(E) "Fixing the preview paths for OpenGraph and Twitter previews"
	$(Q) $(OUTPUT_FILES) | grep "index.html" | $(SED) -E "s|(.+)|$(SED) 's=PREVIEWPATH=\1=' -i \1|g;s|index\.html=|preview.png=|g;s|=./|=https://sandyuraz.com/|g" | sh
	$(E) "Fixing the URLPATHs from html sed"
	$(Q) $(OUTPUT_FILES) | grep "index.html" | $(SED) -E "s|(.+)|$(SED) 's=URLPATH=\1=' -i \1|g;s|index\.html=|=|g;s|=./|=https://sandyuraz.com/|g" | sh
	$(E) "Adding page-specific description to each html file"
	$(Q) $(OUTPUT_FILES) | xargs -n1 sh $(SCRIPT_DESC)
	$(Q) $(NOTIFY) "Sandy's Website" "Build complete!"
