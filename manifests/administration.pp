class nginx::administration {
  include nginx::params

  group { 'nginx-admin':
    ensure => present,
    system => true,
  }
  ->
  sudo::directive { 'nginx-administration':
    ensure  => present,
    content => template('nginx/sudoers.nginx.erb'),
  }

}
