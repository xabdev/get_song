#!/bin/bash


#check if dependencies are installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install it before running this script."
    exit 1
fi

if ! command -v perl &> /dev/null; then
    echo "perl is not installed. Please install it before running this script."
    exit 1
fi

if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp is not installed. Please install it before running this script."
    exit 1
fi




song_url_arr=()


#loop through file.txt and add each line to song_url_arr array
while read line
do
    song_url_arr+=($line) 
done < file.txt


songs=${#song_url_arr[@]}



echo "This songs will be downloaded: "
echo ""


#loop and output the video title
for ((i = 0; i < $songs; i++)); do
    curl -s ${song_url_arr[i]} | perl -MHTML::Entities -ne 'binmode(STDOUT, ":utf8");if(/<title>([^<]*) - YouTube<\/title>/){print decode_entities($1),"\n"}'
    done

echo ""

#loop through array to process yt-dlp commands
for ((i = 0; i < $songs; i++)); do
    echo "> Downloading: " 
    curl -s ${song_url_arr[i]} | perl -MHTML::Entities -ne 'binmode(STDOUT, ":utf8");if(/<title>([^<]*) - YouTube<\/title>/){print decode_entities($1),"\n"}'
    yt-dlp -q --progress -f 'ba' --extract-audio  -o "songs/%(title)s.%(ext)s" ${song_url_arr[i]}
    echo "> done!"
    echo ""
    done