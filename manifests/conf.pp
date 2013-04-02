class nginx::conf {
  file {'/etc/nginx/nginx.conf':
    content => template('nginx/nginx.conf.erb'),
  }

  file { '/usr/local/bin/fcgi-wrapcgi.pl':
    source => 'puppet:///modules/nginx/fcgi-wrapcgi.pl',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { [
    '/etc/nginx/sites-available',
    '/etc/nginx/sites-enabled',
    '/etc/nginx/conf.d',
  ]:
    ensure  => directory,
    purge   => true,
    force   => true,
    recurse => true,
  }
}
