#!/bin/sh

export CANONICALIZERDIST=/www.web3d.org/x3d/tools/canonical/dist/lib

for i in "$@"
do
	export DIRNAME=`dirname "$i"`
 	export ORIGINAL=`basename "$i" -roundtrip.x3d`.x3d
 	export CANON=`basename "$i" -roundtrip.x3d`Canonical.x3d
	export ROUNDTRIP=`basename "$i"`
	export RTCANON=`basename "$i" .x3d`Canonical.x3d
	
	java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ORIGINAL"
	java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP"
	node xmldiff.js "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  diffresults.txt
done
