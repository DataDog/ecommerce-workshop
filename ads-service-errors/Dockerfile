FROM ddtraining/advertisements-fixed:1.0.0

WORKDIR /app
COPY advertisements.patch .
RUN patch ads.py advertisements.patch
