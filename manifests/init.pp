# == Class: profile_lamp
#
# Full description of class profile_lamp here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_lamp
(
) inherits ::profile_lamp::params {
  class { '::profile_lamp::install': } ->
  class { '::profile_lamp::config': } ~>
  class { '::profile_lamp::service': } ->
  Class['::profile_lamp']
}
