# == Class couchpotato::defaults
#
# This class is meant to be called from couchpotato.
# It sets variables according to platform.
#
class couchpotato::defaults {
  $apikey   = '"check https://localhost:9090/config/general/ for your apikey"'
  $user     = 'couchpotato'
  $group    = 'couchpotato'
  $packages = 'couchpotato'
  $services = 'couchpotato'
  $iniconf  = { 'file' => 'settings.conf', 
    'path' => '/var/lib/couchpotato',
    'template' => 'couchpotato/settings.conf.erb' }
  $sysconf = { 'file' => 'couchpotato', 
    'path' => '/etc/sysconfig',
    'template' => 'couchpotato/couchpotato.erb' }
  case $::osfamily {
    'RedHat': {
      $repos    = [ 'http://nuxref.com/repo', ]
    }
    'Suse': {
      $repos    = [
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
