# == Class couchpotato::service
#
# This class is meant to be called from couchpotato.
# It ensure the service is running.
#
class couchpotato::service (
  $services = hiera('couchpotato::service::services',
    $::couchpotato::defaults::services),
) inherits couchpotato::defaults {

  service { [$services]:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
