# Collection of fish functions I have in my config to quickly resize images.

function convert1920x
    magick $argv -resize 1920x $argv
    jpegoptim -s $argv
end

function convert1920strip
    magick $argv -resize 1920x $argv
end

function convert1280x
    magick $argv -resize 1280x $argv
end

function convert1280strip
    magick $argv -resize 1280x $argv
    jpegoptim -s $argv
end

function convert1000xstrip
    magick $argv -resize 1000x -density 1x1 $argv
    jpegoptim -s $argv
end

function convert1000ystrip
    magick $argv -resize x1000 -density 1x1 $argv
    jpegoptim -s $argv
end

function convert750x
    magick $argv -resize 750x $argv
end

function convert500x
    magick $argv -resize 500x $argv
end

function convert300x
    magick $argv -resize 300x $argv
end

function standardize-images-1000
    for img in (find . -type f \( -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.jpg" \))
        set dims (identify -format "%w %h" "$img" 2>/dev/null)
        if test -z "$dims"
            echo "Skipping unreadable file: $img"
            continue
        end

        set width (echo $dims | awk '{print $1}')
        set height (echo $dims | awk '{print $2}')

        if test "$width" -gt "$height"
            echo "Landscape → resizing height for: $img"
            convert1000ystrip "$img"
        else
            echo "Portrait → resizing width for: $img"
            convert1000xstrip "$img"
        end
    end
end
