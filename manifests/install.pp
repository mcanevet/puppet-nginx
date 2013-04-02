class nginx::install {
  package { 'nginx':
    ensure => $nginx::version,
  }
}

