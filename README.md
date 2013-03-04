Puppet autofsck Module
======================

Description
-----------

A simple puppet module to enable automatic / forced / completely unattended
fsck on boot up.  Typically, this means passing the `-y` flag to fsck

Examples
--------

    class { autofsck:
      ensure => present, # default
    }

    or simply

    include autofsck

Copyright
---------

Copyright (C) 2012-2013 Joshua Hoblitt <jhoblitt@cpan.org>
