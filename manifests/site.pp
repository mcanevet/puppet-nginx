define nginx::site($ensure=present,
                  $owner = false,
                  $group = false,
                  $mode  = 2570,
                  $server_name = 'localhost',
                  $doc_root    = '/var/www',
                  $create_root = false,
                  $port = 80,
                  $conf_source = 'nginx/site.conf.erb',
                  $enable_cgi = false) {

  if $owner {
    $_owner = $owner
  } else {
    $_owner = 'root'
  }

  if $group {
    $_group = $group
  } else {
    $_group = $nginx::nginx_user
  }

  $_ensure1 = $ensure? {
    present => directory,
    default => $ensure,
  }

  if $create_root {
    file {"${doc_root}/${name}":
      ensure => $_ensure1,
      owner  => $_owner,
      group  => $_group,
      mode   => $mode,
    }
  }

  file {"/etc/nginx/sites-available/${name}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($conf_source),
  }

  $_ensure2 = $ensure? {
    present => link,
    default => $ensure,
  }

  file {"/etc/nginx/sites-enabled/${name}.conf":
    ensure => $_ensure2,
    target => "../sites-available/${name}.conf",
  }
}
