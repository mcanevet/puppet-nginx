class nginx {
  include nginx::params

  package { 'nginx': 
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => [ Package['nginx'], File['/etc/nginx/nginx.conf'] ],
  }

  exec {"nginx-reload":
    refreshonly => true,
    command     => "nginx -s reload",
    onlyif      => "nginx -t",
  }

  $nginx_user = $nginx::params::nginx_user
  file {'/etc/nginx/nginx.conf':
    ensure  => present,
    content => template('nginx/nginx.conf.erb'),
    require => Package ['nginx'],
  }

  file { '/usr/local/bin/fcgi-wrapcgi.pl':
    source => 'puppet:///modules/nginx/fcgi-wrapcgi.pl',
    mode   => 0755,
    owner  => 'root',
    group  => 'root',
    before => Service['nginx']
  }

  file { ["/etc/nginx/sites-available", "/etc/nginx/sites-enabled", "/etc/nginx/conf.d"]:
    ensure  => directory,
    require => Package['nginx'],
    notify  => Service['nginx'],
    purge   => true,
    force   => true,
    recurse => true,
  }

}
