#!/bin/sh

# export EXAMPLES=/c/Users/coderextreme/Documents/NetBeansProjects/x3d-code/www.web3d.org/x3d/content/examples/X3dForWebAuthors/Chapter14-Prototypes
export EXAMPLES=/c/Users/coderextreme/Documents/NetBeansProjects/x3d-code/www.web3d.org/x3d/content/examples
cat /dev/null > diffresults.txt
find $EXAMPLES -type f -name '*.json' -print0 | xargs -0 node json2x3d.js | xargs -0 sh canonical.sh
