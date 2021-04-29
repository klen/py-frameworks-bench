from pathlib import Path
import datetime as dt
import csv
from collections import namedtuple
import statistics as st
import re

import jinja2


NOW = dt.datetime.utcnow()
BASEDIR = Path(__file__).parent.parent
FRAMEWORKS = BASEDIR / 'frameworks'
SOURCE_HTML = Path(BASEDIR / 'results/html.csv')
SOURCE_UPLOAD = Path(BASEDIR / 'results/upload.csv')
SOURCE_API = Path(BASEDIR / 'results/api.csv')
README = Path(BASEDIR / 'README.md')
README_TEMPLATE = jinja2.Template((BASEDIR / 'render/README.md').read_text())
PAGES_HOME = Path(BASEDIR / 'docs/index.md')
PAGES_HOME_TEMPLATE = jinja2.Template((BASEDIR / 'render/pages/index.md').read_text())
PAGES_RESULTS = Path(BASEDIR / f"docs/_posts/{ NOW.strftime('%Y-%m-%d') }-results.md")
PAGES_RESULTS_TEMPLATE = jinja2.Template((BASEDIR / 'render/pages/results.md').read_text())

Result = namedtuple('Result', ['name', 'req', 'lt50', 'lt75', 'lt90', 'lt_avg', 'es', 'er', 'et'])


def render():
    """Load CSV Results and render it into README."""
    with open(SOURCE_HTML) as csvfile:
        results_html = [
            Result(name, round(int(req) / 15), *row) for name, req, *row in csv.reader(csvfile)]

    with open(SOURCE_UPLOAD) as csvfile:
        results_upload = [
            Result(name, round(int(req) / 15), *row) for name, req, *row in csv.reader(csvfile)]

    with open(SOURCE_API) as csvfile:
        results_api = [
            Result(name, round(int(req) / 15), *row) for name, req, *row in csv.reader(csvfile)]

    results = [
        Result(
            r1.name, (r1.req + r2.req + r3.req) * 15,
            st.mean(map(float, [r1.lt50, r2.lt50, r3.lt50])),
            st.mean(map(float, [r1.lt75, r2.lt75, r3.lt75])),
            st.mean(map(float, [r1.lt90, r2.lt90, r3.lt90])),
            st.mean(map(float, [r1.lt_avg, r2.lt_avg, r3.lt_avg])),
            r1.es + r2.es + r3.es,
            r1.er + r2.er + r3.er,
            r1.et + r2.et + r3.et,
        )
        for r1, r2, r3 in zip(results_html, results_upload, results_api)
    ]

    ctx = dict(
        now=NOW,
        results_html=sorted(results_html, key=lambda res: res.req, reverse=True),
        results_upload=sorted(results_upload, key=lambda res: res.req, reverse=True),
        results_api=sorted(results_api, key=lambda res: res.req, reverse=True),
        results=sorted(results, key=lambda res: res.req, reverse=True),
        versions={
            req.name: parse_version(req.name)
            for req in results_html
        },
    )

    # Render README
    render_template(README_TEMPLATE, README, **ctx)

    # Render pages
    render_template(PAGES_HOME_TEMPLATE, PAGES_HOME, **ctx)
    render_template(PAGES_RESULTS_TEMPLATE, PAGES_RESULTS, **ctx)


def parse_version(name):
    requirements = (FRAMEWORKS / name / 'requirements.txt').read_text()
    version = re.match(f"^\s*{name}[^=]*==\s*(.*)\s*$", requirements, re.MULTILINE)  # noqa
    return version and version.group(1) or ''


def render_template(template, target, **ctx):
    with open(target, 'w') as target:
        target.write(template.render(**ctx))


if __name__ == '__main__':
    render()

# pylama:ignore=D
