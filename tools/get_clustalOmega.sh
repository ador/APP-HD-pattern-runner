#!/bin/bash 
targetDir=$1
wget http://www.clustal.org/omega/clustalo-1.2.0-Ubuntu-x86_64 -O ${targetDir}/clustalo
chmod a+x ${targetDir}/clustalo

