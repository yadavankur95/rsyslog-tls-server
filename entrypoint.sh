#!/bin/bash
set -eu

if [ "${DO_LOG_ALL}" = true ]; then
  echo "Will log all to /var/log/all.log"
else
  echo "Removing config for /var/log/all.log"
  rm /etc/rsyslog.d/all.conf
  rm /etc/logrotate.d/all.conf
  echo "Logging:"
  ls -l /etc/rsyslog.d
  echo "Rotating:"
  ls -l /etc/logrotate.d
fi

if [ "${DO_DUMP_TO_STDOUT}" = true ]; then
  echo "Logs follow"
else
  echo "Does not dump logs to stdout"
  rm /etc/rsyslog.d/stdout.conf
fi

echo "${ROTATE_SCHEDULE} /usr/sbin/logrotate /etc/logrotate.conf" | crontab -
crond -l "${CRON_LOG_LEVEL}"

filePath="/etc/rsyslog/ssl"

if openssl rsa -modulus -noout -in ${filePath}/key.pem > /dev/null 2>&1; then
  echo "Adding SSL config"
  cat > /etc/rsyslog.d/ssl.conf << EOF
  module(load="imtcp" StreamDriver.Name="gtls" StreamDriver.Mode="1" StreamDriver.Authmode="anon")
  input(type="imtcp" port="${RSYSLOG_PORT}")
  global(
    DefaultNetstreamDriver="gtls"
    DefaultNetstreamDriverCAFile="${filePath}/ca.pem"
    DefaultNetstreamDriverCertFile="${filePath}/cert.pem"
    DefaultNetstreamDriverKeyFile="${filePath}/key.pem"
  )
EOF
else
  echo "Adding TCP config"
  cat > /etc/rsyslog.d/tcp.conf << EOF
  module(load="imtcp")
  input(type="imtcp" port="${RSYSLOG_PORT}")
  module(load="imudp")
  input(type="imudp" port="${RSYSLOG_PORT}")
EOF
fi

PIDFILE="/var/run/rsyslogd.pid"
rm -f "${PIDFILE}"
exec rsyslogd -n -f /etc/rsyslogd.conf -i "${PIDFILE}"