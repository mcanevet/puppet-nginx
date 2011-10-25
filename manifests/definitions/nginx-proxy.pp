define nginx::proxy($ensure=present,
                    $server_port=80,
                    $proxy_base='/',
                    $opts=[],
                    $config='nginx/proxy.conf.erb',
                    $proxy_target) {
  include nginx::params
  file {"/etc/nginx/sites-available/${name}.conf":
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
    content => template($config),
    notify  => Exec['nginx-reload'],
  }

  file {"/etc/nginx/sites-enabled/${name}.conf":
    ensure => $ensure? { present => link, default => $ensure},
    target => "../sites-available/${name}.conf",
    notify => Exec['nginx-reload'],
  }

}
