# Fix the youtube links
s|YOUTUBE~|YOUTUBE|g
s|([^~ ])~([^~ ])|\1_\2|g
s|PLAY_YOUTUBE ([^<>]+)|<iframe width="420" height="256" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>|
