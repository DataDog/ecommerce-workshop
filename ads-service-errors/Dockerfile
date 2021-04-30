FROM ddtraining/advertisements-fixed

WORKDIR /app
COPY advertisements.patch .
RUN patch ads.py advertisements.patch
