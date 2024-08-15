# This Puppet manifest fixes file permissions for WordPress
exec { 'fix-wordpress-permissions':
  command => '/bin/bash -c "chown -R www-data:www-data /var/www/html && find /var/www/html -type d -exec chmod 755 {} \\; && find /var/www/html -type f -exec chmod 644 {} \\;"',
  path    => ['/bin', '/usr/bin'],
}
