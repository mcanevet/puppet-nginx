class nginx {
  include nginx::params

  package { 'nginx': 
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }

  exec {"nginx-reload":
    refreshonly => true,
    command     => "nginx -s reload",
    onlyif      => "nginx -t",
  }

  file { '/usr/local/bin/fcgi-wrapcgi.pl':
    source => 'puppet:///nginx/fcgi-wrapcgi.pl',
    mode   => 0755,
    owner  => 'root',
    group  => 'root',
    before => Service['nginx']
  }

  file { ["/etc/nginx/sites-available", "/etc/nginx/sites-enabled", "/etc/nginx/conf.d"]:
    ensure  => directory,
    require => Package['nginx'],
    notify  => Service['nginx'],
    source  => 'puppet:///modules/nginx/empty',
    purge   => true,
    force   => true,
    recurse => true,
  }

}
