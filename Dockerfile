#
# Java Dockerfile 
#
# https://github.com/tamboraorg/docker/crejava
#

# Pull base image.
FROM tamboraorg/creubuntu:latest

MAINTAINER Michael Kahle <michael.kahle@yahoo.de>

ARG BUILD_YEAR=2018
ARG BUILD_MONTH=0
ARG BUILD_TAG=latest

# version: yyyy.n for stable versions / 0.yyyy for development
ENV DEBIAN_FRONTEND noninteractive 
ENV INITRD No
#ENV LANG en_US.UTF-8
ENV JAVA_VERSION 11 

LABEL Name="Java for CRE" \
      CRE=$CRE_VERSION \ 
      Year=$BUILD_YEAR \
      Month=$BUILD_MONTH \
      Version=$JAVA_VERSION \
      OS="Ubuntu:$UBUNTU_VERSION" \
      Build_=$BUILD_TAG 

RUN apt-get update && \
    apt-get install --no-install-recommends -y default-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /cre && touch /cre/versions.txt && \ 
    echo "$(date +'%F %R') \t creJava \t $(java -version 2>&1 | grep version)" >> /cre/versions.txt  

COPY cre /cre
WORKDIR /cre/

#CMD ["/usr/bin/java"]

ENTRYPOINT ["/cre/java-entrypoint.sh"]

CMD ["shoreman", "/cre/java-procfile"]
