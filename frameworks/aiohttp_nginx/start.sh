#!/bin/sh

python app.py --path=/tmp/example_1.sock &
python app.py --path=/tmp/example_2.sock &
python app.py --path=/tmp/example_3.sock &
python app.py --path=/tmp/example_4.sock &

sleep 2

cat <<EOF > /tmp/nginx.conf
error_log /dev/stdout info;

events {
    use           epoll;
    worker_connections  128;
}

http {
  access_log /dev/stdout;
  server {
    listen 8080;
    client_max_body_size 4G;
    server_name localhost;

    location / {
      proxy_redirect off;
      proxy_buffering off;
      proxy_pass http://aiohttp;
    }
  }

  upstream aiohttp {
    # fail_timeout=0 means we always retry an upstream even if it failed
    # to return a good HTTP response

    # Unix domain servers
    server unix:/tmp/example_1.sock fail_timeout=0;
    server unix:/tmp/example_2.sock fail_timeout=0;
    server unix:/tmp/example_3.sock fail_timeout=0;
    server unix:/tmp/example_4.sock fail_timeout=0;

    # Unix domain sockets are used in this example due to their high performance,
    # but TCP/IP sockets could be used instead:
    # server 127.0.0.1:8081 fail_timeout=0;
    # server 127.0.0.1:8082 fail_timeout=0;
    # server 127.0.0.1:8083 fail_timeout=0;
    # server 127.0.0.1:8084 fail_timeout=0;
  }
}
EOF



/usr/sbin/nginx -g 'daemon off;' -c /tmp/nginx.conf
