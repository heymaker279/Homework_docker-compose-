FROM python:3.9
WORKDIR .
COPY ./requirements.txt ./requirements.txt
#RUN pip install psycopg2-binary
RUN pip3 install --no-cache-dir --upgrade -r ./requirements.txt
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY . .
#COPY postgresdb/entrypoint.sh ./docker-entrypoint-initdb.d/entrypoint.sh
RUN /bin/sh -c python3 manage.py makemigrations && /bin/sh -c python3 manage.py migrate
EXPOSE 8000
#ENTRYPOINT ["./docker-entrypoint-initdb.d/entrypoint.sh"]