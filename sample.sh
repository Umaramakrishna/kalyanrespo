#!/bin/bash

yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo " this is server ip: $(hostname)" > /var/www/html/index.html