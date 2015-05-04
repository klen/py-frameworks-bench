Python frameworks' benchmarks
=============================

There are some benchmarks for popular python frameworks.

* [Aiohttp](https://github.com/KeepSafe/aiohttp)   -- Http client/server for asyncio
* [Bottle](https://github.com/bottlepy/bottle)     -- Fast, simple and lightweight WSGI micro web-framework
* [Django](https://github.com/django/django)       -- The Web framework for perfectionists with deadlines
* [Falcon](https://github.com/falconry/falcon)     -- A high-performance Python framework for building cloud APIs
* [Flask](https://github.com/mitsuhiko/flask)      -- A microframework based on Werkzeug, Jinja2 and good intentions
* [Muffin](https://github.com/klen/muffin)         -- A web-framework based on Asyncio stack
* [Pyramid](https://github.com/Pylons/pyramid)     -- A small, fast, down-to-earth, open source Python web framework
* [Tornado](https://github.com/tornadoweb/tornado) -- A Python web framework and asynchronous networking library

The goal of the project is not tests for deployment (like uwsgi vs gunicorn and
etc) but instead tests the frameworks itself.


## The results

See http://klen.github.io/py-frameworks-bench.


## Run benchmarks locally

Let's assume that you have already installed:

[Vagrant](http://www.vagrantup.com) and
[VirtualBox](https://www.virtualbox.org).
[Ansible](http://www.ansible.com/home).

Run the following commands, it will install every dependency that the project
needs, setup any networking, and sync folders :

    $ vagrant up
    $ make provision

Go to your setuped Vagrant environment and run the benchmarks:

    $ vagrant ssh
    $ cd /var/www
    $ sudo /var/www/run_tests

