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
  # add firewall rule for apache
  firewall { '100 allow http and https access':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }

  include ::apache::mod::php

  class {'::epel': }

  package { 'php-mssql':
    ensure  => installed,
    notify  => Service['httpd'],
    require => Class['epel'],
  }

  class {'::mysql::server': }
  class { 'firewall': }
  Firewall {
    before  => Class['profile_lamp::postv4'],
    require => Class['profile_lamp::prev4'],
  }
  class { ['profile_lamp::prev4', 'profile_lamp::postv4']: }
}
