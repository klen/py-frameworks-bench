#!/bin/sh

rm -f {{setup_prefix}}/{{item}}.cvs
rm -f {{setup_prefix}}/{{item}}/stats.cvs

RUNNER="{{setup_prefix}}/wrk/wrk -d {{setup_duration}} -c {{setup_connections}} -s {{setup_prefix}}/wrk/scripts/cvs-report.lua"

cd {{setup_prefix}}/{{item}}

[ ! -r {{setup_prefix}}/{{item}}/src/pid ] && {

    echo "Start service {{item}}"
    start {{item}}

}

echo "Waiting for the service {{item}} is started"
while [ ! -r {{setup_prefix}}/{{item}}/src/pid ]
do
    sleep 1
done

echo "Start hello test"
$RUNNER http://localhost:5000/hello
sleep 1

echo "Start json test"
$RUNNER http://localhost:5000/json
sleep 1

echo "Start remote test"
$RUNNER http://localhost:5000/remote

echo "Stop service {{item}}"
stop {{item}}

echo "Waiting for the service {{item}} is stopped"
while [ -r {{setup_prefix}}/{{item}}/src/pid ]
do
    sleep 1
done

mv {{setup_prefix}}/{{item}}/stats.cvs {{setup_prefix}}/{{item}}.csv
