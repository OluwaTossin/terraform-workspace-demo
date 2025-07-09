#!/bin/bash
echo "Environment: ${terraform.workspace}" > /home/ubuntu/workspace-info.txt

apt update -y
apt install -y nginx

echo "<h1>${terraform.workspace} Environment</h1>" > /var/www/html/index.html