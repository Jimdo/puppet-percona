# Class: percona::install
#
#
class percona::install {
  Package {
    require => Class['percona::preinstall'],
  }

  package { $::percona::package_common:
    ensure => present;
  }

  if $percona::client {
    package { $::percona::package_client:
      ensure  => present,
      require => Package[$percona::package_common];
    }
  }

  if $::percona::server {
    package { $::percona::package_server:
      ensure  => present,
      require => Package[$percona::package_client];
    }
  }
}
