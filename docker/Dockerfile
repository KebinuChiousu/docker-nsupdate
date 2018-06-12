FROM ubuntu:16.04
LABEL maintainer="kevin@meredithkm.info"

RUN apt-get update 
RUN apt-get install -y git
RUN git clone https://github.com/nsupdate-info/nsupdate.info.git nsupdate

WORKDIR /nsupdate
