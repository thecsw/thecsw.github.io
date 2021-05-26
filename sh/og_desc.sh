#!/bin/sh

# Use GNU sed if on Darwin
sedcom="sed -E"
arch=`uname -s`
if [ $arch = "Darwin" ]
then
    sedcom="gsed -E"
fi

# Here is what happens
# 1. We find all the paragraphs in the final html file
# 2. We remove lines that are just timestamps of the webpage
# 3. We grab the very first line after filtering is done in 2.
# 4. Remove the HTML tags in the description
# 5. Preppend the meta property
# 6. Append the closing tags

toinsert=`cat $1 | 
                 grep '<p>' | 
 $sedcom '/H[.]E[.]/d;/20(19|20)\s*<[^<>]+>\s*$/d' | $sedcom -n 1p | $sedcom 's/<[^<>]+>//g' | $sedcom 's|^|/<title/i\\\\<meta property="og:description" content="|' | $sedcom 's|$|...">|'`
$sedcom "$toinsert" -i $1

toinsert=`cat $1 | grep '<p>' | $sedcom '/H[.]E[.]/d;/20(19|20)\s*<[^<>]+>\s*$/d' | $sedcom -n 1p | $sedcom 's/<[^<>]+>//g' | $sedcom 's|^|/<title/i\\\\<meta property="description" content="|' | $sedcom 's|$|...">|'`
$sedcom "$toinsert" -i $1
