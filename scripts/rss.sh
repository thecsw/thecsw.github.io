#!/bin/sh

bin="./darkness.com"

if [[ "$OSTYPE" == "darwin"* ]]; then
    bin="darkness"
fi

${bin} misa -rss feed.xml -rss-dirs ./,anime,blogs,books,plastic,shokugeki,stories,writings
