FROM python:3.8-alpine
LABEL maintainer="PythonicAccountant"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc python3-dev musl-dev libc-dev postgresql-dev
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser