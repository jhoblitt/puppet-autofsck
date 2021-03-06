# == Class: autofsck
#
# Enable unattended fsck on boot
#
# === Parameters
#
# [*ensure*]
#  String. Possible values: 'present', 'absent'
#
#  Enables or disables unattended `fsck`ing on boot.
#
#  Default: 'present'
#
# === Examples
#
#  class { autofsck:
#    ensure => present, # default
#  }
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2012-2013 Joshua Hoblitt
#
class autofsck ($ensure = 'present') {
  validate_re($ensure, '^present$|^absent$')

  case $::osfamily {
    'RedHat': {
      file { '/etc/sysconfig/autofsck':
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        replace => true,
        content => "AUTOFSCK_DEF_CHECK=\"yes\"\nAUTOFSCK_OPT=\"-y\"\n",
      }
    }
    'Debian': {
      $set_fsckfix = $ensure ? {
        'present' => 'yes',
        'absent'  => 'no',
      }
      augeas { 'fsckfix':
        context => '/files/etc/default/rcS',
        changes => "set FSCKFIX ${set_fsckfix}",
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
