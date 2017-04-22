#!/bin/sh

export EXAMPLES=/c/x3d-code/www.web3d.org/x3d/content/examples
cat /dev/null > diffresults.txt
cat /dev/null > javadiffresults.txt
find $EXAMPLES -type f -name '*.json' -print0 | xargs -0 node json2x3d.js | xargs -0 sh canonical.sh
