#!/usr/bin/env python

import sys
import subprocess
import json

frameworks = [
{% for framework in setup_frameworks %}
    '{{framework}}',
{% endfor %}
]

root = "/var/www"
data = {}

for framework in frameworks:
    path = "%s/%s/%s" % (root, framework, 'test.sh')
    subprocess.check_call(path)
    with open('%s.csv' % framework, 'r') as f:
        results = []
        for line in f.readlines():
            line = line.strip()
            results.append([float(c) for c in line.split(',')])
        data[framework] = results

sys.stdout.write(json.dumps(data, indent=2))
