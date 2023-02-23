#!/bin/bash

song_url=""
song_url_arr=()


while read line
do
    song_url_arr+=($line) 
done < file.txt


songs=${#song_url_arr[@]}

echo "Number of songs: $songs"

echo "display number of items in array"
echo $songs




for ((i = 0; i < $songs; i++)); do
    yt-dlp -f 'ba' -x --audio-format mp3 -o "songs/%(title)s.%(ext)s" ${song_url_arr[i]}
    done