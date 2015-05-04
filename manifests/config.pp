# == Class couchpotato::config
#
# This class is called from couchpotato for service config.
#
class couchpotato::config(
  $config_file_source       = undef,
  $config_file_content      = undef,
  $config_file_template     = undef,
){
  $_config_file            = '/var/lib/couchpotato/settings.conf'
  $_servers                = $couchpotato::servers
  $_apikey                 = $couchpotato::apikey
  $_webuser                = $couchpotato::webuser
  $_webpass                = $couchpotato::webpass
  $_data                   = $couchpotato::data_path
  $_library                = $couchpotato::library_path
  $_from                   = $couchpotato::source_path
  $_to                     = $couchpotato::target_path
  $_notification_providers = $couchpotato::notification
  $_nzb_providers          = $couchpotato::nzb
  $_torrent_providers      = $couchpotato::torrent
  $_automation_providers   = $couchpotato::automation
  $_dirs = [
    '/var/lib/couchpotato',$_from, $_to, $_library, $_data,
  ]
  File {
    owner  => $couchpotato::user_name,
    group  => $couchpotato::group_name,
    mode   => '0750',
  }
  ensure_resource('file', $_dirs, {
    ensure => directory,
  })
  if $config_file_source != undef {
    file { $_config_file:
      ensure => file,
      source => $config_file_source,
    }
  } elsif $config_file_content != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_content,
    }
  } elsif $config_file_template != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_template,
    }
  } else {
    file { $_config_file:
      ensure  => file,
      content => template('couchpotato/settings.conf.erb'),
    }
  }
}
