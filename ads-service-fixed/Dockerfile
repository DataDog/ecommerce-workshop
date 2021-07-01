# syntax = docker/dockerfile:1.2
# ^ This enables the new BuildKit stable syntax which can be
# run with the DOCKER_BUILDKIT=1 environment variable in your
# docker build command (see build.sh)
FROM python:3.9.1-slim-buster

# Update, upgrade, and cleanup debian packages
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Bring in app
WORKDIR /app
COPY . .

# Install dependencies via pip and avoid caching build artifacts
RUN pip install --no-cache-dir -r requirements.txt

# Set default Flask app and development environment
ENV FLASK_APP=ads.py
ENV DD_ENV=development

# Listen on 5002
EXPOSE 5002

# Start the app using ddtrace so we have profiling and tracing
ENTRYPOINT ["ddtrace-run"]
CMD ["flask", "run", "--port=5002", "--host=0.0.0.0"]
