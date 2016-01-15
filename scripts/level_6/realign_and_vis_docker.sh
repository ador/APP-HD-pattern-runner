#!/bin/bash

# Note: paths should be absolute
dockerConfLevel5OutPath=/home/yoda/git/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_5/weka_c50_min7_55/
dockerConfLevel6AlignPath=/home/yoda/git/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_6/weka_c50_min7_55/
dockerConfLevel6OutPath=/home/yoda/git/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_6/generated_tex/weka_c50_min7_55/

thisDir=$(dirname $0) || false

pushd ${thisDir}
  ./realign_subtree_seqs.sh ${dockerConfLevel5OutPath} ${dockerConfLevel6AlignPath}
  ./visualize_alignments.sh ${dockerConfLevel6AlignPath} ${dockerConfLevel6OutPath}
popd
