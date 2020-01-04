FROM lambci/lambda:build-provided

LABEL maintainer="Tag Spilman <tag.advance+AWS-Lambda-PHP@gmail.com>"

ENV WORKSPACE=/root/workspace
ENV BUILD_DIR=/root/build

COPY workspace $WORKSPACE

ENTRYPOINT cd $WORKSPACE; make
