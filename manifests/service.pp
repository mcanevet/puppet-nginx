class nginx::service {
  $ensure = $nginx::start ? {true => running, default => stopped}

  service { 'nginx':
    ensure  => $ensure,
    enable  => $nginx::enable,
  }
}
