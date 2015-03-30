# == Class couchpotato::config
#
# This class is called from couchpotato for service config.
#
# (The actual sabndbz.ini file is in the profile::mediaserver module)
#
class couchpotato::config (
  $sysconf = hiera('couchpotato::config::sysconf',
    $::couchpotato::defaults::sysconf),
  $iniconf = hiera('couchpotato::config::iniconf',
    $::couchpotato::defaults::iniconf),
  $home    = hiera('couchpotato::home',
    $::couchpotato::defaults::home),
  $user    = hiera('couchpotato::core::user',
    $::couchpotato::defaults::user),
  $group   = hiera('couchpotato::core::group',
    $::couchpotato::defaults::group),
  $apikey  = hiera('couchpotato::core::api',
    $::couchpotato::defaults::apikey),
  $data    = hiera('couchpotato::core::data', '/var/lib/couchpotato'),
  $pidfile = hiera('couchpotato::pidfile',
    '/var/run/couchpotato.pid'),
  $pass    = hiera('couchpotato::core::password', undef),
  $library = hiera('couchpotato::manage::library', undef),
  $from    = hiera('couchpotato::renamber::from', undef),
  $to      = hiera('couchpotato::renamer::to', undef),
  $servers = hiera('couchpotato::searchers', {}),
  $note_pr = hiera('couchpotato::notifiers', {}),
  $newznab = hiera('couchpotato::newznab::api_key', undef),
  $moviedb = hiera('couchpotato::themoviedb::api_key', undef),
  $cp_home = hiera('couchpotato::home', '/usr/lib/couchpotato'),
) inherits couchpotato::defaults {
  validate_hash($sysconf)
  validate_hash($iniconf)
  validate_string($home)
  validate_string($user)
  validate_string($group)
  validate_string($apikey)
  File {
    owner  => root,
    group  => root,
    mode   => '0644',
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
    ensure    => directory,
    owner     => $user,
    group     => $group,
    mode      => '0750',
    show_diff => false,
  }
  $basename = $iniconf['file']
  $inifile = "${pathname}/${basename}"
  if has_key($iniconf, 'source') {
    file { $inifile:
      source    => $iniconf['source'],
      owner     => $user,
      group     => $group,
      mode      => '0600',
      show_diff => false,
    }
  } elsif has_key($iniconf, 'template') {
    file { $inifile:
      content   => template($iniconf['template']),
      owner     => $user,
      group     => $group,
      mode      => '0600',
      show_diff => false,
    }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
