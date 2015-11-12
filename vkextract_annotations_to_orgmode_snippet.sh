#!/bin/sh
## author: Karl Voit
## license: GPLv3 or newer

PAPERBASENAME="${1}"
NOTES_POSTFIX="-notes"

## the path where all PDF files of papers are stored:
PAPERPATH="${HOME}/archive/library"

## build the exact file name of the annotated PDF file:
## EXAMPLE: for the paper "Name2012.pdf" I keep "Name2012-notes.pdf" with annotations within
PAPER="${PAPERPATH}/${PAPERBASENAME}${NOTES_POSTFIX}.pdf"

## ====  end of configuration section  ===============

## FIXXME: add help/usage


handle_missing_basename()
{
    echo
    echo "ERROR: no argument/parameter for basename given!"
    echo
    echo "Please call this script with one argument as parameter."
    echo
    echo "example:"
    echo "$0 Smith2012"
    echo
    exit 1
}

handle_missing_paperpath()
{
    echo
    echo "ERROR: path \"${PAPERPATH}\" not found!"
    echo
    echo "Please check settings in \"$0\""
    echo "Make sure, \$PAPERPATH points to an existing path containing the paper files."
    echo
    exit 2
}

handle_paper_not_found()
{
    echo
    echo "ERROR: file \"${PAPER}\" not found!"
    echo
    echo "Maybe there are similar files with same base name in \"${PAPERPATH}\""
    echo "that begins with \"${PAPERBASENAME}\" and ends with the defined post-fix \"${NOTES_POSTFIX}\":"
    echo
    echo "vvvv"
    ls -1 ${PAPERPATH}/${PAPERBASENAME}*
    echo "^^^^"
    echo
    exit 3
}

## check for missing ${PAPERBASENAME}
[ "x${PAPERBASENAME}" = "x" ] && handle_missing_basename

## check for non existing ${PAPERPATH}
[ -d "${PAPERPATH}" ] || handle_missing_paperpath

## check for non existing paper file:
[ -f "${PAPER}" ] || handle_paper_not_found


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