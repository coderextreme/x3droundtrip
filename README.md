# x3droundtrip
Roundtripping code of X3D JSON back to X3D XML

json2x3d.js is required from X3DJSONLD, so check it out as well in a sibling folder.

Requires node and Linux/MacOSX

You may want to change the settings in these files:

```
canonical.sh:export CANONICALIZERDIST=/www.web3d.org/x3d/tools/canonical/dist/lib

toxml.sh:export EXAMPLES=/www.web3d.org/x3d/content/examples/ 
```

Installation and running

```
git clone https://github.com/coderextreme/X3DJSONLD
git clone https://github.com/coderextreme/x3droundtrip
cd X3DJSONLD
npm install
cd ../x3drountrip
npm install
sh toxml.sh
```

Results are found in diffresults.txt
