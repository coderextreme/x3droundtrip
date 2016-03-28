cat /dev/null > diffresults.txt
find /www.web3d.org/x3d/content/examples/ -type f -name '*.json' -print0 | xargs -0 node ../X3DJSONLD/json2x3d.js | xargs -0 sh canonical.sh
