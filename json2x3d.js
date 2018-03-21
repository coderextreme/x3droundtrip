"use strict";

// Convert X3D JSON to X3D

process.argv.shift();
process.argv.shift();

var convertJSON = require('./convertJSON.js').convertJSON;

convertJSON([{ 
	serializer : './DOMSerializer.js',
	folder : "../../../",   // where to place output
	extension : "-roundtrip.x3d",
	}]);
