
class rsnapshot::params {
  case $::osfamily {
    'debian': {
      $package = 'rsnapshot'
      $command = '/usr/bin/rsnapshot'
      $config_file = '/etc/rsnapshot.conf'
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $snapshot_root = '/var/cache/rsnapshot/'
  $logfile = '/var/log/rsnapshot.log'
}
