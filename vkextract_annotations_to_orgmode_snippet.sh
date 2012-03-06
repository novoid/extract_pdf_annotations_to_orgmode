#!/bin/sh
## author: Karl Voit
## license: GPLv3 or newer

## the path where all PDF files of papers are stored:
PAPERPATH="${HOME}/archive/papers_from_web"

## build the exact file name of the annotated PDF file:
## EXAMPLE: for the paper "Name2012.pdf" I keep "Name2012-notes.pdf" with annotations within
PAPER="${PAPERPATH}/${1}-notes.pdf"

## extraction of highlighted text (top) and text annotations in form of text boxes or sticky notes:

echo "---- HIGHLIGHTS: ---"
strings ${PAPER} | \
grep "/Type/Annot/Subtype/Highlight"| \
sed 's/.*\/Subj(//'| sed 's/)\/.*//'
echo "\n#+end_example\n\nAnnotations:\n#+begin_example\n---- Annotations: ---"
##OLD: strings ${PAPER}|grep "/Type/Annot/Subtype/Text"| sed 's/.*\/Contents(//'| sed 's/)\/.*//'
strings ${PAPER} | \
egrep "/Type/Annot/Subtype/(Free)?Text"| \
grep -v "/Type/Annot/Subtype/Text/Rect"| \
sed 's/.*\/Contents(//'| sed 's/)\/.*//'


#end