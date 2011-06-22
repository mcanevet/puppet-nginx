class nginx::administration {
  include nginx::params

  group { "apache-admin":
    ensure => present,
  }

  sudo::directive { "nginx-administration":
    ensure => present,
    content => template("nginx/sudoers.nginx.erb"),
    require => Group["nginx-admin"],
  }

}
