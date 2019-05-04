COMPILER = asciidoctor
FLAGS = -a toc
FLAGS = 
NAME = mywebsite
INPUT_TYPE = '*.adoc'
OUTPUT_TYPE = '*.html'

$(NAME):
	find . -type f -name $(INPUT_TYPE) | xargs $(COMPILER) $(FLAGS)
	find . -type f -name $(OUTPUT_TYPE) | xargs sed 's/LinkedIn_LINK/<a href="https:\/\/www.linkedin.com\/in\/thecsw\/">LinkedIn<\/a>/g;s/GitHub_LINK/<a href="https:\/\/github.com\/thecsw">GitHub<\/a>/g;s/Resume_LINK/<a href=".\/resume.pdf">Resume<\/a>/g;s/PGP Key_LINK/<a href="https:\/\/pgp.key-server.io\/pks\/lookup?op=vindex\&search=0xCCE2E27DAC465AC163013F1161BB674C628BB45B">PGP Key<\/a>/g;s/Home_LINK/<a href="https:\/\/thecsw.github.io">Home<\/a>/g;' -i

clean:
	find . -type f -name $(OUTPUT_TYPE) | xargs rm
