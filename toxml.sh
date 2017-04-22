#!/bin/sh
. ./environment
cat /dev/null > diffresults.txt
cat /dev/null > javadiffresults.txt
find $EXAMPLES -type f -name '*.json' -print0 | xargs -0 node json2x3d.js
find $EXAMPLES -type f -name '*-roundtrip.x3d' -print0 | xargs -0 sh canonical.sh
