# syntax = docker/dockerfile:1.2
# ^ This enables the new BuildKit stable syntax which can be
# run with the DOCKER_BUILDKIT=1 environment variable in your
# docker build command (see build.sh)
FROM python:3.9.1-slim-buster
RUN mkdir /app
ADD https://github.com/OJ/gobuster/releases/download/v3.1.0/gobuster-linux-amd64.7z /app
ADD https://github.com/vanhauser-thc/thc-hydra/archive/refs/tags/v9.2.zip /app

# Update, upgrade, and cleanup debian packages
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes libssl-dev libssh-dev libidn11-dev libpcre3-dev \
                 libgtk2.0-dev libmariadb-dev libpq-dev libsvn-dev \
                 firebird-dev libmemcached-dev libgpg-error-dev \
                 libgcrypt20-dev  openssh-client iputils-ping \
                 build-essential libpq-dev p7zip unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create user and the ssh dir
RUN useradd -m user
RUN mkdir -p /home/user/.ssh
COPY keys/storedog-leaked-key /home/user/.ssh/id_rsa

# Bring in app
WORKDIR /app
RUN 7zr e ./gobuster-linux-amd64.7z && chmod +x gobuster
RUN unzip v9.2.zip && cd thc-hydra-9.2/ && ./configure && make && make install
COPY . .

# Update permissions so ssh keys can be accessed outside sudo user
RUN chown -R user:user /home/user/.ssh
RUN chmod +x attack.sh
RUN chown -R user ./keys

USER user

# Run script that attacks another container in the cluster
CMD [ "./attack.sh"]