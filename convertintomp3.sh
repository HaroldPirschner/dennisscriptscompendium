#!/bin/bash

if [ "x$2" == "x" ]; then
   avconv -i "$1" -vn -qscale 1 "$1.mp3"
else
   if [ -e $2 ]; then
      if [ -d "$2" ]; then
         avconv -i "$1" -vn -qscale 1 "$2/$1.mp3"
      fi
   else
      if [ -d "$2" ]; then
         mkdir $2
         avconv -i "$1" -vn -qscale 1 "$2/$1.mp3"
      else
         avconv -i "$1" -vn -qscale 1 "$2"
      fi
   fi
fi
