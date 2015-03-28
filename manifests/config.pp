# == Class couchpotato::config
#
# This class is called from couchpotato for service config.
#
# (The actual sabndbz.ini file is in the profile::mediaserver module)
#
class couchpotato::config (
  $sysconf = hiera('couchpotato::config::sysconf', $::couchpotato::defaults::sysconf),
  $iniconf = hiera('couchpotato::config::iniconf', $::couchpotato::defaults::iniconf),
  $home    = hiera('couchpotato::config::home', $::couchpotato::defaults::home),
  $user    = hiera('couchpotato::config::user', $::couchpotato::defaults::user),
  $group   = hiera('couchpotato::config::group', $::couchpotato::defaults::group),
  $apikey  = hiera('couchpotato::config::apikey', $::couchpotato::defaults::apikey),
) inherits couchpotato::defaults {
  validate_hash($sysconf)
  validate_hash($iniconf)
  validate_string($home)
  validate_string($user)
  validate_string($group)
  validate_string($apikey)
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }
  $confpath = $sysconf['path']
  $confname = $sysconf['file']
  $conf = "${confpath}/${confname}"
  if has_key($sysconf, 'source') {
    file { $conf: source => $sysconf['source'], }
  } elsif has_key($sysconf, 'template') {
    file { $conf: content => template($sysconf['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
  # what about $home/couchpotato.ini ?
  $pathname = $iniconf['path']
  file { $pathname:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }
  $basename = $iniconf['file']
  $inifile = "${pathname}/${basename}"
  if has_key($iniconf, 'source') {
    file { $inifile:
      source => $iniconf['source'],
      owner  => $user,
      group  => $group,
      mode   => '0600',
    }
  } elsif has_key($iniconf, 'template') {
    file { $inifile:
      content => template($iniconf['template']),
      owner   => $user,
      group   => $group,
      mode    => '0600',
    }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
