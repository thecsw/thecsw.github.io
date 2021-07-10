# Fix the youtube links
s|YOUTUBE~|YOUTUBE|g
s|([^~ ])~([^~ ])|\1_\2|g
s|PLAY_YOUTUBE ([^<>]+)|[See the youtube video here](https://youtu.be/\1)|
