# == Class: autofsck
#
# A simple puppet module to enable automatic / forced / completely
# unattended fsck on boot up.  Typically, this means passing the `-y` flag to
# fsck
#
# === Parameters
#
# ensure
#   present|absent - default value is present
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
    RedHat: {
      file { '/etc/sysconfig/autofsck':
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        replace => true,
        content => "AUTOFSCK_DEF_CHECK=\"yes\"\nAUTOFSCK_OPT=\"-y\"\n",
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
