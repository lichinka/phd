#!/bin/bash

# Newer PDF versions are not accepted by the ManuscriptOne system and will fail to convert
if [ -n "$1" ] && [ -n "$2" ]; then 
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
else
    echo "Usage: $0 [file to convert] [converted file]"
fi
