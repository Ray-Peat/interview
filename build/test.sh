#!/bin/bash

SOURCE="./../src/talk/Andrew Murray"
TARGET="./../target"

IMAGE="./../src/img/youtube.png"
SOUND="2010-07-16 Ray Peat + Andrew Murray - Altitude.mp3"

mkdir -p "$TARGET"

ffmpeg -y \
  -loop 1 \
  -r 1/30 \
  -i "$IMAGE" \
  -i "$SOURCE/$SOUND" \
  -vcodec libx264 -tune stillimage \
  -acodec libvo_aacenc \
  -pix_fmt yuv420p \
  -r 30 \
  -shortest \
  -threads 8 \
  "$TARGET/$SOUND.mp4"
