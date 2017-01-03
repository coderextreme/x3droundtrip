#!/bin/sh

export CANONICALIZERDIST=/c/Users/coderextreme/Documents/NetBeansProjects/x3d-code/www.web3d.org/x3d/tools/canonical/dist/lib/
export CLASSPATH="xmlunit/xmlunit-core/target/classes;xmlunit/xmlunit-legacy/target/classes;xmlunit/xmlunit-matchers/target/classes;xmlunit/xmlunit-core/target/xmlunit-core-2.3.1-SNAPSHOT-tests.jar;xmlunit/xmlunit-core/target/xmlunit-core-2.3.1-SNAPSHOT.jar;xmlunit/xmlunit-legacy/target/xmlunit-legacy-2.3.1-SNAPSHOT-sumo.jar;xmlunit/xmlunit-legacy/target/xmlunit-legacy-2.3.1-SNAPSHOT-tests.jar;xmlunit/xmlunit-legacy/target/xmlunit-legacy-2.3.1-SNAPSHOT.jar;xmlunit/xmlunit-matchers/target/xmlunit-matchers-2.3.1-SNAPSHOT-tests.jar;xmlunit/xmlunit-matchers/target/xmlunit-matchers-2.3.1-SNAPSHOT.jar;."
javac Compare.java


cat /dev/null > javadiffresults.txt

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
		echo '#################################################' | tee -a diffresults.txt
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ORIGINAL"
		java -cp $CANONICALIZERDIST/log4j-1.2.15.jar:$CANONICALIZERDIST/xercesImpl.jar:$CANONICALIZERDIST/X3dC14n.jar org.web3d.x3d.tools.x3db.X3dCanonicalizer "$DIRNAME/$ROUNDTRIP"
		echo diff "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  javadiffresults.txt
		java Compare "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  javadiffresults.txt
		node xmldiff.js "$DIRNAME/$CANON" "$DIRNAME/$RTCANON" 2>&1 | tee -a  diffresults.txt
	else 
		echo "No $DIRNAME/$ORIGINAL"
	fi
done
