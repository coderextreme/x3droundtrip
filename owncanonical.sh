#!/bin/sh

. ./environment
javac Compare.java

echo "@1 is when two strings are different lengths" | tee -a owndiffresults.txt
echo "@2 is when two strings are unequal (quoting in word)" | tee -a owndiffresults.txt
echo "@3 is when two strings are unequal (floats different length, platform issues" | tee -a owndiffresults.txt
echo "@4 when the right file has a containerField" | tee -a owndiffresults.txt
echo "@5 when the right file has a key" | tee -a owndiffresults.txt
echo "@6 when the left file has a containerField" | tee -a owndiffresults.txt
echo "@7 when the left file has a key" | tee -a owndiffresults.txt
echo "@8 is when the objects are unequal" | tee -a owndiffresults.txt

# i is _RoundTrip.x3d
for i in "$@"
do
	export DIRNAME=`dirname "$i"`
	export ORIGDIRNAME="../X3DJSONLD/src/main/data"
 	export ORIGINAL=`basename "$i" _RoundTrip.x3d`.x3d
 	export CANON=`basename "$i" _RoundTrip.x3d`Canonical.x3d
	export ROUNDTRIP=`basename "$i"`
	export RTCANON=`basename "$i" .x3d`Canonical.x3d

	if ls "$ORIGDIRNAME/$ORIGINAL"
	then
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$ORIGDIRNAME/$ORIGINAL" 2>&1 > /dev/null
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP" 2>&1 > /dev/null
		# java Compare "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  ownjavadiffresults.txt
		node.exe xmldiff.js "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  owndiffresults.txt
	else 
		echo "No $ORIGDIRNAME/$ORIGINAL"
	fi
done
