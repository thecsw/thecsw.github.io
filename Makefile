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
EXCLUDE_OUTPUT = -not -path "./articles/quick_dirty_js/*" -and -not -path "./present/*"
INPUT_FILES = find . -type f -name '*$(INPUT_TYPE)'
OUTPUT_FILES = find . -type f -name "*$(OUTPUT_TYPE)" $(EXCLUDE_OUTPUT)

$(NAME):
	$(Q) $(NOTIFY) "Sandy's Website" "building..."
	$(E) "	CONVERTING ORG TO ADOC ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | $(SED) -E 's|(.+)\.$(ORIGINAL_TYPE)$$|pandoc -i \1.$(ORIGINAL_TYPE) -o \1.$(INPUT_TYPE)|g' | sh
	$(E) "	MAKING README ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | $(SED) -E 's|(.+)/[^/]+\.$(ORIGINAL_TYPE)$$|pandoc -i \1/index.$(ORIGINAL_TYPE) -o \1/README.md|g' | sh
	$(Q) find . -type f -name "README.md" | xargs $(SED) "1 i ![preview](./preview.png)" -i
	$(E) "	ADJUSTING ADOC"
	$(Q) $(INPUT_FILES) | xargs $(SED) -E -f ./sed/adoc.sed -i
	$(E) "	ADJUSTING THE HOMEPAGE ..."
	$(Q) find . -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs $(SED) 's/| Home_LINK//g;/^:/d' -i
	$(Q) find ./fortunes/ -type f -name '*$(INPUT_TYPE)' | xargs $(SED) '/^:/d' -i
	$(E) "	BUILDING ..."
	$(Q) $(INPUT_FILES) | xargs $(COMPILER) $(FLAGS) 2>/dev/null
	$(E) "	ADJUSTING HTML"
	$(Q) $(OUTPUT_FILES) | xargs $(SED) -E -f ./sed/html.sed -i
	$(Q) $(NOTIFY) "Sandy's Website" "Build complete!"
