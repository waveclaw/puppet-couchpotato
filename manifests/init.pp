# == Class: couchpotato
#
# Organizes installation of Sabnzbd, the users and services.
#
# === Parameters
#
# [*user_name, group_name, user_home*]
#  User to run service as.  Defaults to couchpotato.
#
# [*repo_name*]
#  Operating System specific name of package repositories to use.
#
# [*package_name*]
#  Operating System specific name of package(s) to install.
#
# [*service_name*]
#  Operating System specific name of the service(s) to run.
#
# [*config_file_path*]
#  Where to install the configuration file. Defaults to
#  /var/lib/couchpotato/.config.
#
# [*sysconfig_file_path*]
#  Where to install the runcontrol script's configuration file. OS dependant.
#
# [*sysconfig_file_name*]
#  Name of the runcontrol script's configuration file.  OS dependant.
#
# [*data_path*]
#  Where to keep finished files.  Defaults to /var/lib/couchpotato/Downloads
#
#
#
class couchpotato (
  $user_name           = $::couchpotato::defaults::user_name,
  $user_home           = $::couchpotato::defaults::user_home,
  $group_name          = $::couchpotato::defaults::group_name,
  $repo_name           = $::couchpotato::defaults::repo_name,
  $package_name        = $::couchpotato::defaults::package_name,
  $service_name        = $::couchpotato::defaults::service_name,
  $config_file_path    = $::couchpotato::defaults::config_file_path,
  $sysconfig_file_path = $::couchpotato::defaults::sysconfig_file_path,
  $sysconfig_file_name = $::couchpotato::defaults::sysconfig_file_name,
  $data_path           = $::couchpotato::defaults::data_path,
  $pidfile             = $::couchpotato::defaults::pidfile,
  $servers             = $::couchpotato::defaults::servers,
  $apikey              = $::couchpotato::defaults::apikey,
  $webuser             = $::couchpotato::defaults::webuser,
  $webpass             = $::couchpotato::defaults::webpass,
  $library             = $::couchpotato::defaults::library_path,
  $home_path           = $::couchpotato::defaults::home_path,
  $target_path         = $::couchpotato::defaults::target_path,
  $source_path         = $::couchpotato::defaults::source_path,
  $servers             = $::couchpotato::defaults::servers,
  $nzb                 = $::couchpotato::defaults::nzb,
  $torrent             = $::couchpotato::defaults::torrent,
  $automation          = $::couchpotato::defaults::automation,
  $notification        = $::couchpotato::defaults::notification,
) inherits ::couchpotato::defaults {

  validate_string($user_name)
  validate_string($user_home)
  validate_string($group_name)
  validate_string($sysconfig_file_name)
  validate_string($apikey)
  validate_string($webuser)
  validate_string($webpass)
  validate_absolute_path($data_path)
  validate_absolute_path($config_file_path)
  validate_absolute_path($sysconfig_file_path)
  validate_absolute_path($library)
  validate_absolute_path($target_path)
  validate_absolute_path($source_path)
  validate_absolute_path($home_path)
  validate_absolute_path($pidfile)
  validate_hash($nzb)
  validate_hash($torrent)
  validate_hash($automation)
  validate_hash($notification)
  validate_hash($servers)
  #$repo_name
  #$service_name
  #$package_name

  class { '::couchpotato::users': } ->
  class { '::couchpotato::repo': } ->
  class { '::couchpotato::install': } ->
  class { '::couchpotato::sysconfig': } ->
  class { '::couchpotato::config': } ->
  class { '::couchpotato::service': } ->
  Class['::couchpotato']

  Class ['::couchpotato::sysconfig','::couchpotato::config'] ~>
  Class ['::couchpotato::service']
}
