#!/bin/sh

export CANONICALIZERDIST=/www.web3d.org/x3d/tools/canonical/dist/lib

echo "@1 is when two strings are different lengths" | tee -a owndiffresults.txt
echo "@2 is when two strings are unequal (quoting in word)" | tee -a owndiffresults.txt
echo "@3 is when two strings are unequal (floats different length, platform issues" | tee -a owndiffresults.txt
echo "@4 when the right file has a containerField" | tee -a owndiffresults.txt
echo "@5 when the right file has a key" | tee -a owndiffresults.txt
echo "@6 when the left file has a containerField" | tee -a owndiffresults.txt
echo "@7 when the left file has a key" | tee -a owndiffresults.txt
echo "@8 is when the objects are unequal" | tee -a owndiffresults.txt

for i in "$@"
do
	echo '#################################################' | tee -a owndiffresults.txt
	export DIRNAME=`dirname "$i"`
 	export ORIGINAL=`basename "$i" -roundtrip.x3d`.x3d
 	export CANON=`basename "$i" -roundtrip.x3d`Canonical.x3d
	export ROUNDTRIP=`basename "$i"`
	export RTCANON=`basename "$i" .x3d`Canonical.x3d
	
	java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ORIGINAL"
	java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP"
	node xmldiff.js "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  owndiffresults.txt
done
