Puppet autofsck Module
======================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-autofsck.png)](https://travis-ci.org/jhoblitt/puppet-autofsck)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
    * [Simple](#simple)
    * [Parameters](#parameters)
    * [Enable](#enable)
    * [Disable](#disable)
4. [Limitations](#limitations)
    * [Tested Platforms](#tested-platforms)
5. [Support](#support)


Overview
--------

Enable unattended fsck on boot


Description
-----------

A simple puppet module to enable automatic / forced / completely unattended
`fsck` on boot up.  Typically, this means passing the `-y` flag to `fsck`.
This module does not cause a `fsck` to happen on every boot.  It only takes
affect when a boot time `fsck` is normally triggered.

On most operating systems, a boot time `fsck` will only take place when the
operating system decides that a filesystem needs to be `fsck`ed, typically due
to being 'unclean' or a time / mount number limit between checks has been hit.
These automatic boot time `fsck`s can halt the boot process asking for
administrative interaction to approve making filesystem modifications.  This is
done because `fsck` **can destroy data**.  By using this module you are
accepting the risk of `fsck` destroying file system(s) at boot time.


Usage
-----

### Simple

```puppet
    include autofsck
```

### Parameters

* `ensure`

String. Possible values: 'present', 'absent'

Enables or disables unattended `fsck`ing on boot.

Default: 'present'

### Enable

```puppet
    class { autofsck:
      ensure => present, # default
    }
```

### Disable

```puppet
    class { autofsck:
      ensure => absent,
    }
```


Limitations
-----------

At present, only support for `$::osfamily == 'RedHat'` has been implimented.

### Tested Platforms

* el5.x
* el6.x


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-autofsck/issues)
