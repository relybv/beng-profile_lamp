# == Class profile_lamp::postv4
#
# This class is called from profile_lamp for post config.
#
class profile_lamp::postv4 {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  firewall { '900 log all drop connections':
    proto      => 'all',
    jump       => 'LOG',
    limit      => '5/min',
    log_prefix => 'IPTables-Rejected: ',
    provider   => 'iptables',
  }
  -> firewall { '950 drop udp':
    proto    => 'udp',
    reject   => 'icmp-port-unreachable',
    action   => 'reject',
    provider => 'iptables',
  }
  -> firewall { '951 drop tcp':
    proto    => 'tcp',
    reject   => 'tcp-reset',
    action   => 'reject',
    provider => 'iptables',
  }
  -> firewall { '952 drop icmp':
    proto    => 'icmp',
    action   => 'drop',
    provider => 'iptables',
  }
  -> firewall { '999 drop everything else - this is the failsafe rule':
    proto    => 'all',
    action   => 'drop',
    provider => 'iptables',
    before   => undef,
  }

}
