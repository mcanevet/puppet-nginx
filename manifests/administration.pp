class nginx::administration {
  group { 'apache-admin':
    ensure => present,
    system => true,
  }

  sudo::directive { 'nginx-administration':
    ensure  => present,
    content => template('nginx/sudoers.nginx.erb'),
    require => Group['nginx-admin'],
  }
}
