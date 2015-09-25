#!/usr/bin/env bash

service postgresql-9.4 restart

service nginx restart


# /var/www/html/styleguides/node_modules/.bin/kss-node --config /var/www/html/styleguides/node_modules/kss/demo/kss-config.json
# /var/www/html/styleguides/node_modules/.bin/kss-node --config /var/www/html/styleguides/portal/kss-config.json