FROM alpine:3.12

RUN apk add --no-cache rsyslog logrotate bash

EXPOSE 514/tcp
EXPOSE 514/udp

ENV ROTATE_SCHEDULE='0 * * * *' \
    DO_LOG_ALL=true \
    DO_DUMP_TO_STDOUT=true \
    CRON_LOG_LEVEL=0  #  Most verbose 0, default 8

COPY entrypoint.sh /
COPY etc/ /etc/

ENTRYPOINT ["/entrypoint.sh"]
