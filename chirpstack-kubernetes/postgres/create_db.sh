#!/bin/bash

kubectl exec -i service/postgres  -- psql -v ON_ERROR_STOP=1 postgresdb --username postgresadmin <<-EOSQL
    create role chirpstack_ns with login password 'chirpstack_ns';
    create database chirpstack_ns with owner chirpstack_ns;
EOSQL

kubectl exec -i service/postgres -- psql -v ON_ERROR_STOP=1 postgresdb --username postgresadmin <<-EOSQL
    create role chirpstack_as with login password 'chirpstack_as';
    create database chirpstack_as with owner chirpstack_as;
EOSQL

kubectl exec -i service/postgres -- psql -v ON_ERROR_STOP=1 --username postgresadmin --dbname="chirpstack_as" <<-EOSQL
    create extension pg_trgm;
EOSQL

kubectl exec -i service/postgres -- psql -v ON_ERROR_STOP=1 --username postgresadmin --dbname="chirpstack_as" <<-EOSQL
     create extension hstore;
EOSQL