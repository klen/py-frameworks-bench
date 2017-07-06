#!/bin/sh


$VIRTUAL_ENV/bin/gunicorn app:app \
                          --workers=2 \
                          --bind=0.0.0.0:5000 \
                          --pid=pid \
                          --threads 12
                          # --worker-class=meinheld.gmeinheld.MeinheldWorker
