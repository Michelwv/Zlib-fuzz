#!/bin/bash

#Generate files from /seeds and put them in /corpus
for i in {1000..1002}; do 
  for f in seeds/*; do 
    zzuf -r 0.01 -s $i < "$f" > "corpus/${i}-$(basename "$f")"
  done
done

#Test the files and log to fuzz.log
LC_ALL=C; LANG=C; for f in corpus/*; do 
  echo "File: $f" 
  timeout 3 ./zpipe -d < "$f" > /dev/null 2>&1
  echo "Exit: $?"
  echo "---"
done > fuzz.log
