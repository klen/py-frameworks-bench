#!/usr/bin/env python
import glob
import os
import sys
from setuptools import setup, find_packages

install_requires = [
    'aiohttp',
    'asyncpg',
    'flask',
    'psycopg2',
    'requests',
    'sanic',
]

setup(name='py-frameworks-benchmark',
      version='0',
      description="",
      long_description="",
      packages=find_packages(),
      install_requires=install_requires
)
