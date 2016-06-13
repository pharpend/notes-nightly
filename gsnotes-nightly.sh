#!/bin/bash
#  
# Publishes nightly builds of gsnotes
# 
#     http://notes.harpending.org
# 
# Copied from here:
#
#     https://raw.githubusercontent.com/learnyou/nightly/master/nightly.sh

cleanup () {
    cd
    rm -rf gsnotes 
}

# Filename
GS_EBOOK=`date -u +"gsnotes-nightly-ebook-%Y-%m-%d.pdf"`
GS_PRINT=`date -u +"gsnotes-nightly-print-%Y-%m-%d.pdf"`
# Where things are stored
GSDIR=/usr/share/nginx/notes.harpending.org/math4400
# Start in home directory
cd
# Clone repo
git clone git://github.com/pharpend/gsnotes.git
cd gsnotes
# If nothing changed today, exit
if [[ `git whatchanged --since='24 hours ago'` == "" ]] ; then
    cleanup
    exit 0
fi
# Else, build
make
# Move things
cp gsnotes-ebook.pdf ${GSDIR}/${GS_EBOOK}
cp gsnotes-print.pdf ${GSDIR}/${GS_PRINT}
cd ${GSDIR}
ln -sf ${GS_EBOOK} gsnotes-current-ebook.pdf
ln -sf ${GS_PRINT} gsnotes-current-print.pdf
# Die
cleanup
