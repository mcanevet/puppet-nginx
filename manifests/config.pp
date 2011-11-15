define nginx::config($ensure=present, $file=false, $template=false) {
  if (!$file and !$template) {
    fail "Please define either file or template for $name"
  }

  if ($file and $template) {
    fail "Please define either file OR template for $name"
  }

  file {"/etc/nginx/conf.d/${name}.conf":
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
    notify => Exec['nginx-reload'],
  }

  if $file {
    File["/etc/nginx/conf.d/${name}.conf"] {
      source => $file,
    }
  }

  if $template {
    File["/etc/nginx/conf.d/${name}.conf"] {
      content => $template,
    }
  }
}
