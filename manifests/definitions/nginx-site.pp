define nginx::site($ensure=present,
                  $owner = false,
                  $group = false,
                  mode   = 2570,
                  $server_name = 'localhost',
                  $doc_root    = '/var/www',
                  $port = 80,
                  $conf_source = 'nginx/site.conf.erb', 
                  $enable_cgi = false) {

  include nginx::params

  if $owner {
    $_owner = $owner
  } else {
    $_owner = 'root'
  }

  if $group {
    $_group = $group
  } else {
    $_group = $nginx::params::nginx_user
  }

  file {"${doc_root}/${name}":
    ensure => $ensure? {present => directory, default => $ensure },
    owner  => $_owner,
    group  => $_group,
    mode   => $mode,
  }

  file {"/etc/nginx/sites-available/${name}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($conf_source),
  }

  file {"/etc/nginx/sites-enabled/${name}.conf":
    ensure => $ensure? { present => link, default => $ensure},
    target => "../sites-available/${name}.conf",
    notify => Exec['nginx-reload'],
  }
}
