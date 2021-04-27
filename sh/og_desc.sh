#!/bin/sh

sedcom=sed

toinsert=`cat $1 | grep '<p>' | $sedcom -n 2p | $sedcom "s/<p>//" | $sedcom 's|^|/<title/i\\\\<meta property="og:description" content="|' | $sedcom 's|$|">|'`
$sedcom "$toinsert" -i $1
