# Class: percona::preinstall
#
#
class percona::preinstall {
  case $::operatingsystem {
    'debian', 'ubuntu': {
      apt::key { 'CD2EFD2A':
        ensure => present,
        notify => Exec['apt-get_update'],
      }

      apt::sources_list { 'percona':
        ensure  => present,
        source  => false,
        content => template ('percona/sources.list.erb'),
        notify  => Exec['apt-get_update'];
      }

      exec { 'apt-get update':
        command     => 'apt-get update',
        refreshonly => true;
      }
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      package { 'percona-release':
        ensure   => present,
        provider => 'rpm',
        source   => "http://www.percona.com/redir/downloads/percona-release/percona-release-0.0-1.${::hardwaremodel}.rpm";
      }
    }

    default: {
      fail "Operating system ${::operatingsystem} is not supported."
    }
  }
}
