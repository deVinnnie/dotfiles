#!/bin/sh
#Find all files with the extension .md. -H = Do not follow Symlinks. Execute markdown for each entry.  
find -H . -maxdepth 1 -name \*.md -exec sh -c 'markdown ${0%} > ${0%.md}.html' {} \; 
