#!/bin/bash

kubectl -n influxdb exec -i service/influx -- influx <<-EOSQL
	CREATE USER fogguru WITH PASSWORD 'FogGuru2020' WITH ALL PRIVILEGES
EOSQL

kubectl -n influxdb set env deployment/influx INFLUXDB_HTTP_AUTH_ENABLED=true

kubectl -n influxdb rollout restart deployment influx

kubectl -n influxdb exec -i deployment/influx -- influx -username fogguru -password 'FogGuru2020' <<-EOSQL
    CREATE USER participant WITH PASSWORD 'participant'
EOSQL

kubectl -n influxdb exec -i deployment/influx -- influx -username fogguru -password 'FogGuru2020' <<-EOSQL
    GRANT ALL ON sensor_data TO fogguru
EOSQL

kubectl -n influxdb exec -i deployment/influx -- influx -username fogguru -password 'FogGuru2020' <<-EOSQL
    GRANT READ ON sensor_data TO participant
EOSQL
