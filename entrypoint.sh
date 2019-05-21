#!/bin/sh
set -e

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
  listen 80;

  proxy_http_version 1.1;
  proxy_set_header Upgrade \$http_upgrade;
  proxy_set_header Connection \$connection_upgrade;

  proxy_set_header X-Real-IP \$remote_addr;
  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto \$scheme;
  proxy_set_header X-Forwarded-Host \$host:\$server_port;

  location / {
    proxy_pass "${TARGET}";
  }
}

map \$http_upgrade \$connection_upgrade {
  default upgrade;
  '' close;
}
EOF

exec nginx -g "daemon off;"
