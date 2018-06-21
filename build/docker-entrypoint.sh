#!/usr/bin/env bash

/usr/local/bin/confd -onetime -backend env

python3 manage.py collectstatic
python3 manage.py migrate
python3 manage.py create-superuser --preserve --username $DJANGO_SUPERUSER --password $DJANGO_SUPERPASS --email $DJANGO_EMAIL

uwsgi --uid=www-data --gid=www-data --ini uwsgi.ini
