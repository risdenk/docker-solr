#!/bin/bash

TEMPLATE=Dockerfile.template.trunk
BUILD_NUMBER=$(curl -sSL https://builds.apache.org/job/Solr-Artifacts-trunk/lastSuccessfulBuild/buildNumber)
SOLR_VERSION="6.0.0-$BUILD_NUMBER"

set -x
cp $TEMPLATE "trunk/Dockerfile"
sed -r -i -e 's/^(ENV SOLR_VERSION) .*/\1 '"$SOLR_VERSION"'/' "trunk/Dockerfile"

git add trunk
git commit -m "Updated Solr trunk to $SOLR_VERSION"
git push origin solr-trunk
