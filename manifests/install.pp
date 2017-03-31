# == Class profile_lamp::install
#
# This class is called from profile_lamp for install.
#
class profile_lamp::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class {'::apache':
    mpm_module => 'prefork',
  }

  include ::apache::mod::php

  class {'::epel': }

  package { 'php-mssql':
    ensure  => installed,
    notify  => Service['httpd'],
    require => Class['epel'],
  }

  class {'::mysql::server': }
}
