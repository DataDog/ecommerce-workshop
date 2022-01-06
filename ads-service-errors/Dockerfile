#FROM ddtraining/advertisements-fixed:1.0.0
FROM econocombrasil/advertisements-service:fixed

WORKDIR /app
COPY advertisements.patch .
RUN patch ads.py advertisements.patch
