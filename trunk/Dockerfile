
FROM    java:openjdk-8-jre
MAINTAINER  Kevin Risden "risdenk@avalonconsult.com"

RUN apt-get update && \
  apt-get -y install lsof && \
  rm -rf /var/lib/apt/lists/*

ENV SOLR_USER solr
ENV SOLR_UID 8983

RUN groupadd -r $SOLR_USER && \
  useradd -r -u $SOLR_UID -g $SOLR_USER $SOLR_USER

ENV SOLR_VERSION 6.0.0-2796

RUN mkdir -p /opt/solr && \
  wget -nv --output-document=/opt/solr.tgz https://builds.apache.org/job/Solr-Artifacts-trunk/lastSuccessfulBuild/artifact/solr/package/solr-$SOLR_VERSION.tgz && \
  tar -C /opt/solr --extract --file /opt/solr.tgz --strip-components=1 && \
  rm /opt/solr.tgz* && \
  mkdir -p /opt/solr/server/solr/lib && \
  chown -R $SOLR_USER:$SOLR_USER /opt/solr

EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER
CMD ["/opt/solr/bin/solr", "-f"]
