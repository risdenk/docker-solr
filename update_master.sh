#!/bin/bash

set -e -o pipefail
set -x 

BUILD_NUMBER=$(curl -sSL -f https://builds.apache.org/job/Solr-Artifacts-master/lastSuccessfulBuild/buildNumber)
SOLR_VERSION="9.0.0-$BUILD_NUMBER"

rm -rf master/*
cp -r scripts master/
cp Dockerfile.template.master "master/Dockerfile"
gsed -r -i -e 's/^(ENV SOLR_VERSION) .*/\1 '"$SOLR_VERSION"'/' "master/Dockerfile"

mkdir -p master/alpine
cp -r scripts master/alpine/
cp Dockerfile-alpine.template.master "master/alpine/Dockerfile"
gsed -r -i -e 's/^(ENV SOLR_VERSION) .*/\1 '"$SOLR_VERSION"'/' "master/alpine/Dockerfile"

git add master
git commit -S -m "Updated Solr master to $SOLR_VERSION"
git push origin solr-master
