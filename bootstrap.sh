#!/usr/bin/env bash

apt-get update
# Git and development-related installs
apt-get install -y build-essential git zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
# Varnish and Apache web installs
apt-get install -y wget varnish apache2 net-tools
# Python and Gunicorn installs
apt-get install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools gunicorn

# Toy Flask/Python web app will be running on port 8888
pip3 install flask
cp /vagrant/toyapp.service /etc/systemd/system
systemctl start toyapp
systemctl enable toyapp

# Apache will be running on port 8080
systemctl start apache2
systemctl enable apache2
sudo sed -i -e 's/80/8080/g' /etc/apache2/ports.conf
sudo sed -i -e 's/80/8080/g' /etc/apache2/sites-available/*
systemctl restart apache2

# Varnish will be running on port 80
systemctl start varnish
systemctl enable varnish
sed -i -e 's/6081/80/g' /etc/default/varnish
sed -i -e 's/6081/80/g' /lib/systemd/system/varnish.service
/lib/systemd/system/varnish.service
cp /etc/varnish/default.vcl /etc/varnish/default.vcl.bak
cp /vagrant/default.vcl /etc/varnish
systemctl daemon-reload
systemctl restart varnish

# Install ModSecurity for Apache
apt-get install -y libapache2-mod-security2
cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
systemctl restart apache2
