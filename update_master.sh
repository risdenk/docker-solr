#!/bin/bash

set -e -o pipefail
set -x 

TEMPLATE=Dockerfile.template.master
BUILD_NUMBER=$(curl -sSL -f https://builds.apache.org/job/Solr-Artifacts-master/lastSuccessfulBuild/buildNumber)
SOLR_VERSION="7.0.0-$BUILD_NUMBER"

cp $TEMPLATE "master/Dockerfile"
sed -r -i -e 's/^(ENV SOLR_VERSION) .*/\1 '"$SOLR_VERSION"'/' "master/Dockerfile"

git add master
git commit -m "Updated Solr master to $SOLR_VERSION"
git push origin solr-master
