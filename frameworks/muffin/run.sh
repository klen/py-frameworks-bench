#!/bin/sh


$VIRTUAL_ENV/bin/muffin app run --workers=2 --bind=0.0.0.0:5000 --pid=pid
