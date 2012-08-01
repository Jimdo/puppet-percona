# Class percona::params
#
#
class percona::params {
  $client           = true
  $server           = false
  $config_dir_mode  = '0755'
  $config_file_mode = '0644'
  $config_group     = 'root'
  $config_user      = 'root'
  $daemon_group     = 'mysql'
  $daemon_user      = 'mysql'
  $datadir          = '/var/lib/mysql'
  $errorlog         = '/var/log/mysqld.log'
  $logdir           = '/var/log/percona'
  $pidfile          = '/var/run/mysqld/mysqld.pid'
  $service_name     = 'mysql'
  $socket           = '/var/lib/mysql/mysql.sock'
  $targetdir        = '/data/backups/mysql/'

  case $::operatingsystem {
    'debian', 'ubuntu': {
      $confdir         = '/etc/mysql'
      $config          = '/etc/mysql/my.cnf'
      $package_client  = "percona-server-client-5.5"
      $package_server  = "percona-server-server-5.5"
      $package_common  = [
        'percona-toolkit',
        "percona-server-common-5.5"
      ]
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      $config         = '/etc/my.cnf'
      $package_client = "Percona-Server-client-55"
      $package_server = "Percona-Server-server-55"
      $package_common = [
        'percona-toolkit',
        'Percona-Server-shared-compat',
        "Percona-Server-devel-55",
        "Percona-Server-shared-55",
      ]
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
