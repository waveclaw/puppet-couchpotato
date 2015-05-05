# == Class couchpotato::sysconfig
#
# This class is called from couchpotato for system control config
#
# Parameters
#
# [*source, content, template*]
#   Override the content on a whole-file basis. No default.
#   Templates will only have access to already defined variables.
#
class couchpotato::sysconfig(
  $source       = undef,
  $content      = undef,
  $template     = undef,
){
  $_file_path      = $couchpotato::sysconfig_file_path
  $_file_name      = $couchpotato::sysconfig_file_name
  $_sysconfig_file = "${_file_path}/${_file_name}"

  $_user           = $couchpotato::user_name
  $_home           = $couchpotato::config_home_path
  $_data           = $couchpotato::data_path
  $_group          = $couchpotato::group_name
  $_pidfile        = $couchpotato::pidfile

  File {
    owner  => $_user,
    group  => $_group,
    mode   => '0750',
  }
  if $source != undef {
    file { $_sysconfig_file:
      ensure => file,
      source => $source,
    }
  } elsif $content != undef {
    file { $_sysconfig_file:
      ensure  => file,
      content => $content,
    }
  } elsif $template != undef {
    file { $_sysconfig_file:
      ensure  => file,
      content => $template,
    }
  } else {
    file { $_sysconfig_file:
      ensure  => file,
      content => template("couchpotato/${_file_name}.erb"),
    }
  }
}
