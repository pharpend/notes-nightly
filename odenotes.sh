#!/bin/bash
#  
# Publishes nightly builds of odenotes
# 
#     http://notes.harpending.org
# 
# Copied from here:
#
#     https://raw.githubusercontent.com/learnyou/nightly/master/nightly.sh

cleanup () {
    cd
    rm -rf odenotes 
}

# Filename
ODE_EBOOK=`date -u +"odenotes-nightly-ebook-%Y-%m-%d.pdf"`
ODE_PRINT=`date -u +"odenotes-nightly-print-%Y-%m-%d.pdf"`
# Where the notes are stored
ODEDIR=/usr/share/nginx/notes.harpending.org/math2280
# Start in home directory
cd
# Clone repo
git clone git://github.com/pharpend/odenotes.git
cd odenotes
# If nothing changed today, exit
if [[ `git whatchanged --since='24 hours ago'` == "" ]] ; then
    cleanup
    exit 0
fi
# Else, build
make
# Move thinode
cp odenotes-ebook.pdf ${ODEDIR}/${ODE_EBOOK}
cp odenotes-print.pdf ${ODEDIR}/${ODE_PRINT}
cd ${ODEDIR}
ln -sf ${ODE_EBOOK} odenotes-current-ebook.pdf
ln -sf ${ODE_PRINT} odenotes-current-print.pdf
# Die
cleanup
