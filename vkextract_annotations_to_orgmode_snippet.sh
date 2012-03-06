#!/bin/sh

PAPERPATH="${HOME}/archive/papers_from_web"
PAPER="${PAPERPATH}/${1}-notes.pdf"

echo "---- HIGHLIGHTS: ---"
strings ${PAPER}|grep "/Type/Annot/Subtype/Highlight"| sed 's/.*\/Subj(//'| sed 's/)\/.*//'
echo "\n#+end_example\n\nAnnotations:\n#+begin_example\n---- Annotations: ---"
##strings ${PAPER}|grep "/Type/Annot/Subtype/Text"| sed 's/.*\/Contents(//'| sed 's/)\/.*//'
strings ${PAPER} | \
egrep "/Type/Annot/Subtype/(Free)?Text"| \
grep -v "/Type/Annot/Subtype/Text/Rect"| \
sed 's/.*\/Contents(//'| sed 's/)\/.*//'


#end