# == Class: nginx
#
# Install and configure nginx
#
# == Parameters
# [*nginx_user*]
#   The user thats runs nginx
#
# [*version*]
#   The package version to install
#
# [*enable*]
#   Should the service be enabled during boot time?
#
# [*start*]
#   Should the service be started by Puppet
class nginx(
  $nginx_user = $::osfamily ? {
    Debian => 'www-data',
    RedHat => 'nginx',
  },
  $version = 'present',
  $enable = true,
  $start = true,
) {
  class{'nginx::install':}
  class{'nginx::conf':}
  class{'nginx::service':}

  Class['nginx::install'] ->
  Class['nginx::conf'] ~>
  Class['nginx::service']

  Class['nginx::install'] ->
  Nginx::Config <| |> ~>
  Class['nginx::service']

  Class['nginx::install'] ->
  Nginx::Proxy <| |> ~>
  Class['nginx::service']

  Class['nginx::install'] ->
  Nginx::Site <| |> ~>
  Class['nginx::service']

  Class['nginx::service'] ->
  Class['nginx']
}
