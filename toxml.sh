#!/bin/sh

. ./environment

cat /dev/null > diffresults.txt
cat /dev/null > javadiffresults.txt

javac Compare.java

echo "@1 is when two strings are different lengths" | tee -a diffresults.txt
echo "@2 is when two strings are unequal (quoting in word, entities)" | tee -a diffresults.txt
echo "@3 is when two strings are unequal (floats different length, platform issues" | tee -a diffresults.txt
echo "@4 when the right file has a containerField" | tee -a diffresults.txt
echo "@5 when the right file has a key" | tee -a diffresults.txt
echo "@6 when the left file has a containerField" | tee -a diffresults.txt
echo "@7 when the left file has a key" | tee -a diffresults.txt
echo "@8 is when the objects are unequal" | tee -a diffresults.txt

find $EXAMPLES -type f -name '*.json' -print0 | xargs -0 node json2x3d.js
find $EXAMPLES -type f -name '*_RoundTrip.x3d' -print0 | xargs -0 bash canonical.sh
egrep '^(=|C|@|M|<|>)' diffresults.txt > results.txt
jar -cMf results.data.zip results.txt
grep xmldiff results.txt| awk '{ print $2; print $3; }'| xargs jar -uef results.data.zip
echo output file is results.data.zip
