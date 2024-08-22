# This Puppet manifest configures the system to handle more open files for users

# Set the maximum number of open files
file_line { 'increase_user_limit':
  path  => '/etc/security/limits.conf',
  line  => '* soft nofile 1024',
  match => '^* soft nofile',
}

file_line { 'increase_user_limit_hard':
  path  => '/etc/security/limits.conf',
  line  => '* hard nofile 4096',
  match => '^* hard nofile',
}

# Ensure limits are applied for new sessions
exec { 'reload_limits':
  command => 'sysctl -p',
  path    => '/usr/sbin:/sbin:/bin:/usr/bin',
  refreshonly => true,
  notify  => Exec['reload_limits'],
}
