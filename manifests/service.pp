# == Class couchpotato::service
#
# This class is meant to be called from couchpotato.
# It ensure the service is running.
#
class couchpotato::service {

  service { $couchpotato::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
