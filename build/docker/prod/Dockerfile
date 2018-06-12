FROM python:3-slim-jessie
LABEL maintainer="kevin@meredithkm.info"

RUN mkdir /static
RUN mkdir /upload

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends git python3 python3-pip \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/nsupdate-info/nsupdate.info.git nsupdate

COPY ./build/bin/pip /bin/pip

WORKDIR /nsupdate

RUN pip install -r requirements.d/prod.txt
RUN pip install -e .

VOLUME /static
