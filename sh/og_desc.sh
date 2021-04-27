#!/bin/sh

# Use GNU sed if on Darwin
sedcom="sed -E"
arch=`uname -s`
if [ $arch = "Darwin" ]
then
    sedcom="gsed -E"
fi

toinsert=`cat $1 | grep '<p>' | $sedcom "/H[.]E[.]/d;/2020\s*$/d" | $sedcom -n 1p | $sedcom 's/<p>//' | $sedcom 's/<[^<>]+>//g' | $sedcom 's|^|/<title/i\\\\<meta property="og:description" content="|' | $sedcom 's|$|">|'`
$sedcom "$toinsert" -i $1

toinsert=`cat $1 | grep '<p>' | $sedcom "/H[.]E[.]/d;/2020\s*$/d" | $sedcom -n 1p | $sedcom 's/<p>//' | $sedcom 's/<[^<>]+>//g' | $sedcom 's|^|/<title/i\\\\<meta property="description" content="|' | $sedcom 's|$|">|'`
$sedcom "$toinsert" -i $1
