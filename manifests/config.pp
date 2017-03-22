# == Class profile_lamp::config
#
# This class is called from profile_lamp for service config.
#
class profile_lamp::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
