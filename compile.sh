#!/bin/sh

find . -type f | grep '\.adoc$' | xargs asciidoctor
sed '445s/LinkedIn/<a href="https:\/\/www.linkedin.com\/in\/thecsw\/">LinkedIn<\/a>/g' -i index.html
sed '445s/GitHub/<a href="https:\/\/github.com\/thecsw">GitHub<\/a>/g' -i index.html
sed '445s/Resume/<a href=".\/resume.pdf">Resume<\/a>/g' -i index.html
sed '445s/PGP Key/<a href="https:\/\/pgp.key-server.io\/pks\/lookup?op=vindex\&search=0xCCE2E27DAC465AC163013F1161BB674C628BB45B">PGP Key<\/a>/g' -i index.html
