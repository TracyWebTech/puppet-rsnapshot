# == Class: rsnapshot
#
# Full description of class rsnapshot here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { rsnapshot:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class rsnapshot (
  $package = $rsnapshot::params::package,
  $command = $rsnapshot::params::command,
  $config_file = $rsnapshot::params::config_file,
) inherits rsnapshot::params {

  ensure_packages([$package])

  cron { 'rsnapshot hourly':
    user    => root,
    command => "$command hourly",
    minute  => 0,
  }

  cron { 'rsnapshot daily':
    user    => root,
    command => "$command daily",
    minute  => 30,
    hour    => 3,
  }

  cron { 'rsnapshot weekly':
    user    => root,
    command => "$command weekly",
    minute  => 0,
    hour    => 3,
    weekday => 'Sunday',
  }

  cron { 'rsnapshot monthly':
    user     => root,
    command  => "$command monthly",
    minute   => 30,
    hour     => 3,
    monthday => 1,
  }

  file { $config_file:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('rsnapshot/rsnapshot.conf.erb'),
  }

  file { '/etc/rsnapshot.includes':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 0644,
  }
}
