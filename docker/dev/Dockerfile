FROM meredithkm/nsupdate:dev
LABEL maintainer="kevin@meredithkm.info"

ENV DJANGO_SETTINGS_MODULE=local_settings

ADD ./docker/dev/dev.py /nsupdate/local_settings.py

RUN python3 manage.py collectstatic
