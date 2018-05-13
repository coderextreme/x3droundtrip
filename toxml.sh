#!/bin/sh
. ./environment
cat /dev/null > diffresults.txt
cat /dev/null > javadiffresults.txt
find $EXAMPLES -type f -name '*.json' -print0 | xargs -0 node.exe json2x3d.js
find $EXAMPLES -type f -name '*-roundtrip.x3d' -print0 | xargs -0 sh canonical.sh
egrep '^(=|C|@|M|<|>)' diffresults.txt > results.txt
jar -cMf results.data.zip results.txt
grep xmldiff results.txt| awk '{ print $2; print $3; }'| xargs jar -uMf results.data.zip
echo output file is results.data.zip
