#!/bin/sh
set -e
export PGPASSWORD=$DB_PASSWORD

psql -v ON_ERROR_STOP=1 --username "$DB_USER" --dbname "$DB_NAME" <<-EOSQL
    CREATE ROLE "$DB_USER" with SUPERUSER PASSWORD "$DB_PASSWORD";

EOSQL

psql  -v ON_ERROR_STOP=1 --username "$DB_USER" --dbname "$DB_NAME" < $DUMP_FILE
set -e

export PGPASSWORD=$DB_PASSWORD

psql  -v ON_ERROR_STOP=1 --username "$DB_USER" --dbname "$DB_NAME" <<-EOSQL
  SET client_encoding TO 'UTF8';
  \t
  \a

EOSQL



python manage.py flush --no-input
python manage.py migrate
python manage.py collectstatic
#gunicorn stocks_products.wsgi -b 0.0.0.0:8000




exec "$@"