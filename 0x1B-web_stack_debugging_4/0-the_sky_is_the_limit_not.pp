# This Puppet manifest configures Nginx to handle more concurrent requests effectively

# Ensure the Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Configure Nginx to handle more connections
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => '
worker_processes  4;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    log_format  main  \'$remote_addr - $remote_user [$time_local] "$request" \'
                      \'$status $body_bytes_sent "$http_referer" \'
                      \'"$http_user_agent" "$http_x_forwarded_for"\';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    tcp_nopush     on;
    tcp_nodelay    on;
    keepalive_timeout  65;
    server {
        listen       80;
        server_name  localhost;
        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
    }
}
',
  notify  => Service['nginx'],
}

# Ensure the Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
}
