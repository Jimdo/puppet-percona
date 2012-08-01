class percona::config::client {
  if $percona::client {
    File {
      owner   => $percona::config_user,
      group   => $percona::config_group,
      notify  => Service[$percona::service_name],
      require => Class['percona::install'],
    }
  }
}
