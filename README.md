# x3droundtrip
Roundtripping code of X3D JSON back to X3D XML

json2x3d.js is required from X3DJSONLD, so check it out as well in a sibling folder.

Requires Linux/MacOS/Cygwin/MingW64

You may want to change the settings in these files:

```
environment:export CANONICALIZERDIST=/c/x3d-code/ww.web3d.org/x3d/tools/canonical/dist/lib

toxml.sh:export EXAMPLES=/c/x3d-code/www.web3d.org/x3d/content/examples/ 

json2x3d.js:change location of folder to the parent of x3d-code (see above) This is where canonicalizer files and roundtrip files are placed.
```

Installation and running.  Installation will download additional packages with additional licenses in node_modules.

```
git clone https://github.com/coderextreme/X3DJSONLD
git clone https://github.com/coderextreme/x3droundtrip
cd X3DJSONLD
npm install
cd src/main/shell
sh stripnumbers.sh
cd ../../../../x3drountrip
npm install
bash toxml.sh
```

Results are found in diffresults.txt
