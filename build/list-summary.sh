#!/bin/bash

SOURCE="./../src/talk"
TARGET="./../target/summary"

mkdir -p "$TARGET"

cat make.log | while read name; do read link

  name=${name/'Loading ./../target/'/}
  name=${name/'.mp4'/}

  link=${link/'Video uploaded: '/}
  link=${link/'&feature=youtube_gdata'/}

  echo "### $name ::: $link"

  file="$TARGET/$name (summary).md"

  echo "[$name]" >  "$file"
  echo "($link)" >> "$file"
  echo ""        >> "$file"
  echo "[Start]" >> "$file"
  echo "($link#t=1m23s)" >> "$file"

done
