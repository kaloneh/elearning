FROM python:3.7-alpine

ENV KMDB_ELEARNING_VERSION 1.0.0
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt

RUN apk update -qf && apk upgrade -qf && pip install -r requirements.txt

RUN adduser -D kmdb
RUN mkdir /kmdb/elearning -p
WORKDIR /kmdb/elearning
COPY ./elearning /kmdb/elearning
USER kmdb
CMD ['django','admin','runserver']
