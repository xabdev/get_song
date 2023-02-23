#!/bin/bash

song_url=""
song_url_arr=()


#loop through file.txt and add each line to song_url_arr array
while read line
do
    song_url_arr+=($line) 
done < file.txt


songs=${#song_url_arr[@]}

echo "Number of songs: $songs"

echo "display number of items in array"
echo $songs


#loop through array to process yt-dlp commands
for ((i = 0; i < $songs; i++)); do
    echo ""
    echo "> Downloading: " 
    curl -s ${song_url_arr[i]} | perl -MHTML::Entities -ne 'binmode(STDOUT, ":utf8");if(/<title>([^<]*) - YouTube<\/title>/){print decode_entities($1),"\n"}'
    yt-dlp -q --progress --newline -f 'ba' -x --audio-format m4a -o "songs/%(title)s.%(ext)s" ${song_url_arr[i]}
    echo "> done!"
    echo ""
    done