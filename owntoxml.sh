rm ../X3DJSONLD/*roundtrip*
rm ../X3DJSONLD/*Canonical*
cat /dev/null > owndiffresults.txt
ls ../X3DJSONLD/*.x3d| sed 's/\.x3d$/.json/g' | xargs node json2x3d.js | xargs -0 sh owncanonical.sh
