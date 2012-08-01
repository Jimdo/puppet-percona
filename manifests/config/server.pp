class percona::config::server {
  if $percona::server {
    File {
      owner   => $percona::config_user,
      group   => $percona::config_group,
      notify  => Service[$percona::service_name],
      require => Class['percona::install'],
    }

    if $percona::confdir {
      file { $percona::confdir:
        ensure => directory;
      }
    }

    file {
      $percona::config:
        ensure  => present,
        content => template ("percona/my.cnf.${::operatingsystem}.erb");

      $percona::datadir:
        ensure => directory,
        mode   => '0700';
    }
  }
}
