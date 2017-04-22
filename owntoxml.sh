#!/bin/sh

rm ../X3DJSONLD/*roundtrip*
rm ../X3DJSONLD/*Canonical*
cat /dev/null > owndiffresults.txt
cat /dev/null > ownjavadiffresults.txt
ls ../X3DJSONLD/*.x3d|grep -v new | sed 's/\.x3d$/.json/g' | xargs node json2x3d.js
ls ../X3DJSONLD/*-roundtrip.x3d | xargs sh owncanonical.sh
