#!/bin/sh
. ./environment
javac Compare.java
echo Compare john2.x3d john2.new.json.intermediate.x3d
java -Xss1g -Xmx4g Compare john2.x3d john2.new.json.intermediate.x3d
echo Compare john2.x3d john2.new.x3d
java -Xss1g -Xmx4g Compare john2.x3d john2.new.x3d
echo Compare john2.x3d john2.x3d.new
java -Xss1g -Xmx4g Compare john2.x3d john2.x3d.new
