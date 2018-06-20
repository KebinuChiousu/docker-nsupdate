#!/usr/bin/env bash

/usr/local/bin/confd -onetime -backend env

python3 manage.py collectstatic
python3 manage.py migrate
python3 manage.py createsuperuser

uwsgi --ini uwsgi.ini
