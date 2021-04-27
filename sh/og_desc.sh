#!/bin/sh

sedcom=sed

toinsert=`cat $1 | grep '<p>' | $sedcom "/H[.]E[.]/d" | $sedcom -n 1p | $sedcom "s/<p>//" | $sedcom 's/<[^<>]+>//g' | $sedcom 's|^|/<title/i\\\\<meta property="og:description" content="|' | $sedcom 's|$|">|'`
$sedcom "$toinsert" -i $1

toinsert=`cat $1 | grep '<p>' | $sedcom "/H[.]E[.]/d" | $sedcom -n 1p | $sedcom "s/<p>//" | $sedcom 's|^|/<title/i\\\\<meta property="description" content="|' | $sedcom 's|$|">|'`
$sedcom "$toinsert" -i $1
