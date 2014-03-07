
class rsnapshot::params {
  case $::osfamily {
    'debian': {
      $package = 'rsnapshot'
      $command = '/usr/bin/rsnapshot'
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
