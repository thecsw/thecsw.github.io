# Fix the youtube links
s|YOUTUBE~|YOUTUBE|g
s|([^~ ])~([^~ ])|\1_\2|g
s|PIC ([^<>]+)::([^<>]+)|![\2](\1)|

# Fix some of the image links
s|_\.png|.png|g

s|SPOTIFY ([^<>]+)|<iframe src="https://open.spotify.com/embed/track/\1" width="79%" height="80" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>|

s|SPOTIFYPLAYLIST ([^<>]+)|<iframe src="https://open.spotify.com/embed/playlist/\1" width="79%" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>|

s|YOUTUBE ([^<>]+)|<iframe width="100%" height="330px" src="https://www.youtube.com/embed/\1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>|

s|GIST ([^<>]+)|<script src="https://gist.github.com/\1.js"></script>|
