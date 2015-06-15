#!/bin/sh

rm -f {{setup_prefix}}/{{item}}.cvs
rm -f {{setup_prefix}}/{{item}}/stats.cvs

message () {
    echo "
[{{item}}] $1
====================
"
}

RUNNER="{{setup_prefix}}/wrk/wrk -d{{setup_duration}} -c{{setup_connections}} -t{{setup_threads}} --timeout {{setup_timeout}} -s {{setup_prefix}}/wrk/scripts/cvs-report.lua"

cd {{setup_prefix}}/{{item}}

[ ! -r {{setup_prefix}}/{{item}}/src/pid ] && {

    message "Start service"
    start {{item}}

}

message "Waiting for the service is started"
while [ ! -r {{setup_prefix}}/{{item}}/src/pid ]
do
    sleep 1
done

message "Start json tests"
$RUNNER http://localhost:5000/json
sleep 1

message "Start remote tests"
$RUNNER http://localhost:5000/remote
sleep 1

message "Start complete tests"
$RUNNER http://localhost:5000/complete

message "Stop service"
stop {{item}}

message "Waiting for the service is stopped"
while [ -r {{setup_prefix}}/{{item}}/src/pid ]
do
    sleep 1
done

mv {{setup_prefix}}/{{item}}/stats.cvs {{setup_prefix}}/{{item}}.csv
