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
    'path' => '/var/lib/couchpotato/',
    'template' => 'couchpotato/settings.conf.erb' }
  $sysconf = { 'file' => 'couchpotato', 
    'template' => 'couchpotato/couchpotato.erb' }
  case $::osfamily {
    'Debian': {
      $repos    = 'ppa:jcfp/ppa'
      $sysconf['path'] = '/etc/defaults'
    }
    'RedHat': {
      $repos    = [ 'http://nuxref.com/repo/', ]
      $sysconf['path'] = '/etc/sysconfig'
    }
    'Suse': {
      $repos    = [
        join([ 'http://download.opensuse.org/repositories',
          'Archiving/SLE_12'],'/'),
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
      $sysconf['path'] = '/etc/sysconfig'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
