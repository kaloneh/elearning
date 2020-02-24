FROM python:3.7-alpine

ENV KMDB_ELEARNING_VERSION 1.0.0
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir -p /kmdb/elearning
WORKDIR /kmdb/elearning
COPY ./app /kmdb/elearning

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D kmdb
RUN chown -R kmdb:kmdb /vol/
RUN chmod -R 755 /vol/web
USER kmdb
