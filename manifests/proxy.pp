define nginx::proxy($proxy_target,
                    $ensure=present,
                    $server_name=$name,
                    $server_port=80,
                    $proxy_base='/',
                    $opts=[],
                    $config='nginx/proxy.conf.erb',) {
  file {"/etc/nginx/sites-available/${name}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($config),
  }

  $_ensure = $ensure? {
    present => link,
    default => $ensure,
  }

  file {"/etc/nginx/sites-enabled/${name}.conf":
    ensure => $_ensure,
    target => "../sites-available/${name}.conf",
  }

}
