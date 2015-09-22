#!/usr/bin/env bash

echo 'RUNNING POSTGRESQL INSTALL....'

# Install PostgreSQL 9.4
yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6.6-x86_64/pgdg-centos94-9.4-1.noarch.rpm

yum -y install postgresql94-server postgresql94-contrib

# Initiate PGDB
#/usr/pgsql-9.4/bin/postgresql94-setup initdb
service postgresql-9.4 initdb

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=vagrant
APP_DB_PASS=vagrant

# Edit the following to change the name of the database that is created
APP_DB_NAME=smbedit

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.4

###########################################################
# Changes below this line are probably not necessary
###########################################################
print_db_usage () {
  echo "Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (defined in VAGRANTFILE)"
  echo "  Host: localhost"
  echo "  Port: 15432"
  echo "  Database: $APP_DB_NAME"
  echo "  Username: $APP_DB_USER"
  echo "  Password: $APP_DB_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost $APP_DB_NAME"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$APP_DB_USER:$APP_DB_PASS@localhost:15432/$APP_DB_NAME"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost -p 15432 $APP_DB_NAME"
}

PG_DIR="/var/lib/pgsql/$PG_VERSION/main"
PG_CONF="/var/lib/pgsql/$PG_VERSION/data/postgresql.conf"
PG_HBA="/var/lib/pgsql/$PG_VERSION/data/pg_hba.conf"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Switch to md5 for localhost
sed -i "/^host/s/ident/trust/g" "$PG_HBA"
# Append to pg_hba.conf to add password auth for other connections
echo "host    all             all             all                     trust" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
#systemctl restart postgresql-9.4

service postgresql-9.4 restart

# Create user and database with new user as owner
cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER WITH SUPERUSER CREATEDB PASSWORD '$APP_DB_PASS';

-- Create the database:
CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER;

CREATE DATABASE $APP_DB_USER WITH OWNER=$APP_DB_USER;
EOF

# postgres -D /usr/local/pgsql/data >logfile 2>&1 &
postgres -D /var/lib/pgsql/9.4/data >logfile 2>&1 &

echo "Successfully created PostgreSQL dev virtual machine."
echo ""

print_db_usage

# Append to startup file
if [ -f /etc/startup.sh ]; then
cat <<EOF >> /etc/startup.sh
#systemctl restart postgresql-9.4
#systemctl enable postgresql-9.4
service postgresql-9.4 restart
EOF
fi
