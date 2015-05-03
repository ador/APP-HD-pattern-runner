#!/bin/bash
targetDir=$1
wget ftp://toolkit.lmb.uni-muenchen.de/pub/kClust/kClust -O ${targetDir}/kClust
chmod a+x ${targetDir}/kClust
