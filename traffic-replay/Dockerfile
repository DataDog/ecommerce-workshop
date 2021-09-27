FROM bash:5.1

RUN wget -O /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && chmod +x /usr/local/bin/wait-for-it.sh
RUN wget -q -O - https://github.com/buger/goreplay/releases/download/v1.1.0/gor_1.1.0_x64.tar.gz | tar -xz -C /usr/local/bin

COPY requests_0.gor /
ENTRYPOINT wait-for-it.sh -t 0 ${FRONTEND_HOST:-frontend}:${FRONTEND_PORT:-3000} -s -- gor --input-file-loop --input-file requests_0.gor --output-http "http://${FRONTEND_HOST:-frontend}:${FRONTEND_PORT:-3000}"
