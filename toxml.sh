export EXAMPLES=/www.web3d.org/x3d/content/examples/ 
cat /dev/null > diffresults.txt
find "$EXAMPLES" -type f -name '*.json' -print0 | xargs -0 node json2x3d.js | xargs -0 sh canonical.sh
