FROM python:3.7-alpine

ENV KMDB_ELEARNING_VERSION 1.0.0
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt

RUN apt update -y && apt upgrade -y \
    pip install django>=2.10 &&
    pip -r requirements.txt

RUN useradd -D kmdb
RUN mkdir /kmdb/elearning
WORKDIR /kmdb/elearning
COPY ./elearning /kmdb/elearning
USER kmdb
CMD ['django','admin','runserver']
