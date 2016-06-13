#!/bin/bash
#  
# Publishes nightly builds of jltnotes
# 
#     http://notes.harpending.org
# 
# Copied from here:
#
#     https://raw.githubusercontent.com/learnyou/nightly/master/nightly.sh

cleanup () {
    cd
    rm -rf jltnotes 
}

# Filename
JLT_EBOOK=`date -u +"jltnotes-nightly-ebook-%Y-%m-%d.pdf"`
JLT_PRINT=`date -u +"jltnotes-nightly-print-%Y-%m-%d.pdf"`
# Where the notes are stored
JLTDIR=/usr/share/nginx/notes.harpending.org/math3220
# Start in home directory
cd
# Clone repo
git clone git://github.com/pharpend/jltnotes.git
cd jltnotes
# If nothing changed today, exit
if [[ `git whatchanged --since='24 hours ago'` == "" ]] ; then
    cleanup
    exit 0
fi
# Else, build
make
# Move thinjlt
cp jltnotes-ebook.pdf ${JLTDIR}/${JLT_EBOOK}
cp jltnotes-print.pdf ${JLTDIR}/${JLT_PRINT}
cd ${JLTDIR}
ln -sf ${JLT_EBOOK} jltnotes-current-ebook.pdf
ln -sf ${JLT_PRINT} jltnotes-current-print.pdf
# Die
cleanup
