FROM ubuntu:16.04
LABEL maintainer="kevin@meredithkm.info"

ENV DJANGO_SETTINGS_MODULE=local_settings

RUN apt-get update 
RUN apt-get install -y git python3-pip vim
RUN git clone https://github.com/nsupdate-info/nsupdate.info.git nsupdate

COPY ./build/bin/pip /bin/pip

WORKDIR /nsupdate

RUN pip install -r requirements.d/dev.txt
RUN pip install -e .
