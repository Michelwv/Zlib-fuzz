#!/bin/bash

#Generate files from /seeds and put them in /corpus
for f in seeds/*; do
  basename_f=$(basename "$f" .gz)
  radamsa -n 10 -o "corpus/radamsa-%n-${basename_f}.gz" "$f"
done

#Test the files and log to fuzz.log
LC_ALL=C; LANG=C; for f in corpus/*; do 
  echo "File: $f" 
  timeout 3 ./zpipe -d < "$f" > /dev/null 2>&1
  echo "Exit: $?"
  echo "---"
done > fuzz.log
