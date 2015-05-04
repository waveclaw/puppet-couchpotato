# == Class couchpotato::install
#
# This class is called from couchpotato for install.
#
class couchpotato::install {
  $_packages = $couchpotato::package_name
  ensure_resource('package', $_packages,
    { 'ensure' => 'present' })
}
