#!/bin/sh

. ./environment
javac Compare.java

echo "@1 is when two strings are different lengths" | tee -a diffresults.txt
echo "@2 is when two strings are unequal (quoting in word, entities)" | tee -a diffresults.txt
echo "@3 is when two strings are unequal (floats different length, platform issues" | tee -a diffresults.txt
echo "@4 when the right file has a containerField" | tee -a diffresults.txt
echo "@5 when the right file has a key" | tee -a diffresults.txt
echo "@6 when the left file has a containerField" | tee -a diffresults.txt
echo "@7 when the left file has a key" | tee -a diffresults.txt
echo "@8 is when the objects are unequal" | tee -a diffresults.txt

# i is -roundtrip.x3d
for i in "$@"
do
	export DIRNAME=`dirname "$i"`
 	export ORIGINAL=`basename "$i" -roundtrip.x3d`.x3d
 	export CANON=`basename "$i" -roundtrip.x3d`Canonical.x3d
	export ROUNDTRIP=`basename "$i"`
	export RTCANON=`basename "$i" .x3d`Canonical.x3d

	if ls "$DIRNAME/$ORIGINAL"
	then
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ORIGINAL" 2>&1 > /dev/null
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP" 2>&1 > /dev/null
		# java Compare "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  javadiffresults.txt
		node xmldiff.js "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  diffresults.txt
	else 
		echo "No $DIRNAME/$ORIGINAL"
	fi
done
