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
EXCLUDE_OUTPUT = -not -path "./articles/quick_dirty_js/*"
INPUT_FILES = find . -type f -name '*$(INPUT_TYPE)'
OUTPUT_FILES = find . -type f -name "*$(OUTPUT_TYPE)" $(EXCLUDE_OUTPUT)

$(NAME):
	$(Q) $(NOTIFY) "Sandy's Website" "building..."
	$(E) "	CONVERTING ORG TO ADOC ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | sed -E 's|(.+)\.$(ORIGINAL_TYPE)$$|pandoc -i \1.$(ORIGINAL_TYPE) -o \1.$(INPUT_TYPE)|g' | sh
	$(E) "	MAKING README ..."
	$(Q) find . -type f -name '*$(ORIGINAL_TYPE)' $(EXCLUDE_ORIGINAL) | sed -E 's|(.+)/[^/]+\.$(ORIGINAL_TYPE)$$|pandoc -i \1/index.$(ORIGINAL_TYPE) -o \1/README.md|g' | sh
	$(Q) find . -type f -name "README.md" | xargs sed "1 i ![preview](./preview.png)" -i
	$(E) "	ADJUSTING ADOC"
	$(Q) $(INPUT_FILES) | xargs sed -E -f ./sed/adoc.sed -i
	$(E) "	ADJUSTING THE HOMEPAGE ..."
	$(Q) find . -maxdepth 1 -type f -name '*$(INPUT_TYPE)' | xargs sed 's/| Home_LINK//g;/^:/d' -i
	$(Q) find ./fortunes/ -type f -name '*$(INPUT_TYPE)' | xargs sed '/^:/d' -i
	$(E) "	BUILDING ..."
	$(Q) $(INPUT_FILES) | xargs $(COMPILER) $(FLAGS) 2>/dev/null
	$(E) "	ADJUSTING HTML"
	$(Q) $(OUTPUT_FILES) | xargs sed -E -f ./sed/html.sed -i
	$(Q) $(NOTIFY) "Sandy's Website" "Build complete!"
