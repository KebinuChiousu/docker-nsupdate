FROM debian:stable-slim
LABEL maintainer="kevin@meredithkm.info"

ARG BUILD=prod

ENV UWSGI_INI /nsupdate/uwsgi.ini
ENV DJANGO_SETTINGS_MODULE=local_settings
ENV SECRET_KEY=S3cr3t
ENV BASEDOMAIN=nsupdate.localdomain

RUN mkdir /static
RUN mkdir /upload

# Install python3 and pip
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
       git \ 
       python3 \ 
       python3-setuptools \ 
       python3-pip \ 
       build-essential \ 
       gcc \ 
       libpython3.5-dev \ 
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Make dirs
RUN mkdir -p /etc/confd/{conf.d,templates}

# Add templates
COPY build/confd/ /etc/confd/

# Add confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# Set up the ENTRYPOINT
COPY build/docker-entrypoint.sh /var/local/
RUN chmod a+x /var/local/docker-entrypoint.sh

# Clone latest version of nsupdate from GitHub
RUN git clone https://github.com/nsupdate-info/nsupdate.info.git nsupdate

# Install easy-install wrapper scripts
COPY ./build/bin/pip /bin/pip

WORKDIR /nsupdate

RUN pip install wheel
RUN python3 setup.py bdist_wheel
RUN pip install psycopg2 uwsgi
RUN pip install -r requirements.d/$BUILD.txt
RUN pip install -e .

ADD build/uwsgi.ini uwsgi.ini

VOLUME /static
VOLUME /upload

ENTRYPOINT ["/var/local/docker-entrypoint.sh"]
