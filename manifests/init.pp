# Class: percona
#
# This class installs percona
#
# Parameters:
#
# Actions:
#   - Install PerconaDB
#
# Requires:
#   - camp2camp puppet-apt module:
#     source: https://github.com/camptocamp/puppet-apt
#
# Sample Usage:
#
#  node server {
#    class { 'percona':
#      server => 'true',
#    }
#  }
#
#  node client {
#    class {
#      'percona':;
#    }
#  }
#
class percona (
  $client           = $::percona::params::client,
  $server           = $::percona::params::server,
  $config_dir_mode  = $::percona::params::config_dir_mode,
  $config_file_mode = $::percona::params::config_file_mode,
  $config_group     = $::percona::params::config_group,
  $config_user      = $::percona::params::config_user,
  $daemon_group     = $::percona::params::daemon_group,
  $daemon_user      = $::percona::params::daemon_user,
  $datadir          = $::percona::params::datadir,
  $errorlog         = $::percona::params::errorlog,
  $logdir           = $::percona::params::logdir,
  $package_client   = $::percona::params::package_client,
  $package_server   = $::percona::params::package_server,
  $pidfile          = $::percona::params::pidfile,
  $service_name     = $::percona::params::service,
  $socket           = $::percona::params::socket,
  $targetdir        = $::percona::params::targetdir,
) inherits percona::params {
  # motd::register { 'percona': }

  include percona::params
  include percona::preinstall
  include percona::install
  include percona::config
  include percona::service

  Class['percona::params'] ->
  Class['percona::preinstall'] ->
  Class['percona::install'] ->
  Class['percona::config'] ->
  Class['percona::service']
}
