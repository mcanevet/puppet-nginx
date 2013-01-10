class nginx::params {
  $nginx_user = $::operatingsystem ? {
    Debian => 'www-data',
    Ubuntu => 'www-data',
    RedHat => 'nginx',
    Fedora => 'nginx',
    CentOS => 'nginx',
  }
}
