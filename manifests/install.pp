# == Class couchpotato::install
#
# This class is called from couchpotato for install.
#
class couchpotato::install (
  $packages = hiera('::couchpotato::install::packages',
    $::couchpotato::defaults::packages),
) inherits couchpotato::defaults {
  ensure_resource('package', $packages,
    { 'ensure' => 'present' })
}
