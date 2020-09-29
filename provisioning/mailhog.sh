#!/usr/bin/env bash

echo "Installing MailHog..."

apt-get install -y \
golang-go

GOPATH=/opt/go \
go get github.com/mailhog/MailHog

ln -s /opt/go/bin/MailHog /usr/local/bin/MailHog

# Create MailHog service file
cat <<EOT > /etc/systemd/system/mailhog.service
[Unit]
Description=MailHog service

[Service]
ExecStart=/usr/local/bin/MailHog

[Install]
WantedBy=multi-user.target
EOT

# Add MailHog to autorun
update-rc.d mailhog defaults

# Start MailHog service
service mailhog start

# Install postfix as deliverer
DEBIAN_FRONTEND=noninteractive \
apt-get install -y \
postfix

# Configure postfix
postconf -e "relayhost = 127.0.0.1:1025"
postconf -e "inet_interfaces = loopback-only"
postconf -e "default_transport = smtp"
postconf -e "relay_transport = error"

# Reload service
service postfix reload

exit $?
