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
5. [Versioning](#versioning)
6. [Support](#support)
7. [See Also](#see-also)


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

`String` Possible values: 'present', 'absent'. Defaults to: 'present'

Enables or disables unattended `fsck`ing on boot.

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

At present, only supports Debian and Redhat based distributions.

### Tested Platforms

* el5.x
* el6.x
* Ubuntu/Debian


Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-autofsck/issues)


See Also
--------

 * [EL6 `/etc/rc.d/rc.sysinit` script](https://git.fedorahosted.org/cgit/initscripts.git/tree/rc.d/rc.sysinit?id=initscripts-9.03.40-1)
 * [Ubuntu QuickTip #4](https://help.ubuntu.com/community/QuickTips#Tip_.234_Check_for_and_fix_filesystem_errors_on_boot)
