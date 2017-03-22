# == Class profile_lamp::params
#
# This class is meant to be called from profile_lamp.
# It sets variables according to platform.
#
class profile_lamp::params {
  $ntpservers = [ '172.18.99.210', '172.18.99.211' ]
}
