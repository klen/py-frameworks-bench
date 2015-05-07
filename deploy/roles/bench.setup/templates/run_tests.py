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
cdata = {}
tdata = {}, {}, {}

for framework in frameworks:
    path = "%s/%s/%s" % (root, framework, 'test.sh')
    subprocess.check_call(path)
    with open('%s.csv' % framework, 'r') as f:
        results = []
        marker = 0
        for line in f.readlines():
            line = line.strip()
            nums = [float(c) for c in line.split(',')]
            _, p50, p75, _, _, _, _, avg, dur, req, err = nums
            tdata[marker][framework] = p50, p75, avg, req / dur, err / req
            marker += 1
            results.append(nums)
        cdata[framework] = results

for data in tdata:
    sys.stdout.write('\n' + json.dumps(data) + '\n')
sys.stdout.write('\n' + json.dumps(cdata) + '\n')
