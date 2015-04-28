#!/bin/bash

# find out where we are
thisDir=$(dirname $0) || false

# create a directory for the dataset if it does not exist
mkdir -p ${thisDir}/../data/uniprot-rel_2015_04
pushd ${thisDir}/../data/uniprot-rel_2015_04 > /dev/null
  echo "Starting download, might take a while ..."
  wget ftp://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2015_04/knowledgebase/uniprot_sprot-only2015_04.tar.gz
  echo "Swissprot dataset downloaded at $(date)" > last_download_when.txt
  echo "Extracting files ..."
  tar xvfz uniprot_sprot-only2015_01.tar.gz
  echo "Unzipping files ..."
  gunzip uniprot_sprot.dat.gz
  gunzip uniprot_sprot.fasta.gz
  echo "Done."
popd > /dev/null

