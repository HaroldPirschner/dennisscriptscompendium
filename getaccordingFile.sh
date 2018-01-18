#!/bin/bash



while read line; do
  foundFile=`find . -name "*$line*"`
  echo $line,$foundFile
done <data.txt

