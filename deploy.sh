#!/bin/bash

set -e

echo "Starting deployment..."

echo "Connecting to MariaDB server: $DB_HOST"

mysql \
-h "$DB_HOST" \
-u "$DB_USER" \
-p"$DB_PASS" \
-e "SHOW DATABASES;"

echo "Database connection successful."
