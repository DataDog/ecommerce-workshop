FROM python:3.9.1-alpine3.12
RUN apk add build-base eudev-dev cython postgresql-dev linux-headers
COPY requirements.txt /app/requirements.txt
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
