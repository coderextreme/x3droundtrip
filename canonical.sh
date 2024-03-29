#!/bin/sh

. ./environment

# i is _RoundTrip.x3d
for i in "$@"
do
	export DIRNAME=`dirname "$i"`
	export NEWDIR=$HOME/`dirname "$i" | sed "s/\/c\/x3d-code\/www.web3d.org/X3DJSONLD\/src\/main\/x3d_code\/www_web3d_org/"`
 	export ORIGINAL=`basename "$i" _RoundTrip.x3d`.Snew.x3d
 	export CANON=`basename "$i" _RoundTrip.x3d`.SnewCanonical.x3d
	export ROUNDTRIP=`basename "$i"`
	export RTCANON=`basename "$i" .x3d`Canonical.x3d

	if ls "$NEWDIR/$ORIGINAL" > /dev/null
	then
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$NEWDIR/$ORIGINAL" 2>&1 >> canonicalizer.txt
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP" 2>&1 >> canonicalizer.txt
		# java Compare "$NEWDIR/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  javadiffresults.txt
		node xmldiff.js "$NEWDIR/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  diffresults.txt
		# echo diff "$NEWDIR/$CANON" "$DIRNAME/$RTCANON" 
		# diff -w "$NEWDIR/$CANON" "$DIRNAME/$RTCANON"  | grep -v 'DOCTYPE'
	else
		echo "No $NEWDIR/$ORIGINAL"
	fi
done
