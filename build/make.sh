#!/bin/bash


SOURCE="./../src/talk"
TARGET="./../target"

IMAGE="./../src/img/youtube.png"

FONT="/usr/share/fonts/truetype/freefont/FreeSerif.ttf"

mkdir -p "$TARGET"

convert_resource () { 

  local file=$1
  local name=$(basename "$file" ".mp3")

  echo "### $name"

  local sound="$file"
  local video="$TARGET/$name.mp4"

  ffmpeg \
    -loop 1 \
    -r 1/30 \
    -i "$IMAGE" \
    -i "$sound" \
    -vf	drawtext="fontfile=$FONT: fontsize=20: fontcolor=white: x=100: y=200: text=$name" \
    -vcodec libx264 -tune stillimage -pix_fmt yuv420p \
    -acodec libvo_aacenc \
    -r 30 \
    -s 426x240 \
    -shortest \
    -threads 8 \
    "$video"
  
  google youtube post \
    --category "Education" \
    --tags "Ray Peat" \
    --access=private \
    --title "$name" \
    --summary "$name" \
    "$video"

} 

find $SOURCE -type f -name "*.mp3" | sort | while read file
do
  convert_resource "$file"
done
