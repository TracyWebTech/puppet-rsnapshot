
class rsnapshot (
  $package = $rsnapshot::params::package,
  $command = $rsnapshot::params::command,
  $config_file = $rsnapshot::params::config_file,
) inherits rsnapshot::params {

  ensure_packages([$package])

  cron { 'rsnapshot hourly':
    user    => root,
    command => "${command} hourly",
    minute  => 0,
    hour    => '*/4',
  }

  cron { 'rsnapshot daily':
    user    => root,
    command => "${command} daily",
    minute  => 30,
    hour    => 3,
  }

  cron { 'rsnapshot weekly':
    user    => root,
    command => "${command} weekly",
    minute  => 0,
    hour    => 3,
    weekday => 'Sunday',
  }

  cron { 'rsnapshot monthly':
    user     => root,
    command  => "${command} monthly",
    minute   => 30,
    hour     => 3,
    monthday => 1,
  }

  file { $config_file:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('rsnapshot/rsnapshot.conf.erb'),
  }

  file { '/etc/rsnapshot.includes':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }
}
