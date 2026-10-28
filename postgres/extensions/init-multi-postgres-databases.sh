#!/bin/bash

set -e
set -u

# Creates each database in POSTGRES_MULTIPLE_DATABASES owned by $POSTGRES_USER, skipping any that already exist
function create_database() {
	local database=$1
	echo "  Creating database '$database'"
	if psql --username "$POSTGRES_USER" --dbname postgres -tAc "SELECT 1 FROM pg_database WHERE datname = '$database'" | grep -q 1; then
		echo "  Database '$database' already exists, skipping"
		return
	fi
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname postgres <<-EOSQL
	    CREATE DATABASE "$database" OWNER "$POSTGRES_USER";
EOSQL
}

if [ -n "${POSTGRES_MULTIPLE_DATABASES:-}" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo "$POSTGRES_MULTIPLE_DATABASES" | tr ',' ' '); do
		create_database "$db"
	done
	echo "Multiple databases created"
fi
