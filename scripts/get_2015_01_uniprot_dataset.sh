#!/bin/bash

# find out where we are
thisDir=$(dirname $0) || false

# create a directory for the dataset if it does not exist
mkdir -p ${thisDir}/../data/uniprot-rel_2015_01
pushd ${thisDir}/../data/uniprot-rel_2015_01 > /dev/null
  echo "Starting download, might take a while ..."
  wget ftp://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2015_01/knowledgebase/uniprot_sprot-only2015_01.tar.gz
  echo "Swissprot dataset downloaded at $(date)" > last_download_when.txt
  echo "Extracting files ..."
  tar xvfz uniprot_sprot-only2015_01.tar.gz
  # todo: more levels of compression?
  echo "Done."
popd > /dev/null

