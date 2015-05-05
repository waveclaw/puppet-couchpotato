# == Class couchpotato::defaults
#
# This class is meant to be called from couchpotato.
# It sets variables according to platform.
#
class couchpotato::defaults {
  $user_name           = 'couchpotato'
  $user_home           = '/uar/lib/couchpotato'
  $group_name          = 'couchpotato'
  $package_name        = 'couchpotato'
  $service_name        = 'couchpotato'
  $config_file_path    = '/var/lib/couchpotato'
  $home_path           = '/usr/lib/couchpotato'
  $sysconfig_file_name = 'couchpotato'
  $data_path           = $config_file_path
  $pidfile             = '/var/run/couchpotato.pid'
  $apikey              =
    '"check https://localhost:5050/#config/ for your apikey"'
  $webuser             = undef
  $webpass             = undef
  $library_path        = $config_file_path
  $target_path         = "${config_file_path}/Movies"
  $source_path         = "${config_file_path}/Downloads"
  $servers             = {}
  $nzb                 = {}
  $torrent             = {}
  $automation          = {}
  $notification        = {}
  case $::osfamily {
    'Debian': {
      $sysconfig_file_path = '/etc/defaults'
      $repo_name = undef # have to get it from source -
      # http://github.com/RuudBurger/CouchPotatoServer.git
    }
    'RedHat': {
      $sysconfig_file_path = '/etc/sysconfig'
      $repo_name = [ 'http://nuxref.com/repo', ]
    }
    'Suse': {
      $sysconfig_file_path = '/etc/sysconfig'
      $repo_name = [
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
