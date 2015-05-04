# == Class couchpotato::users
#
# This class is called from couchpotato for pre-install user setup.
#
class couchpotato::users {
  group { $::couchpotato::group_name:
    ensure => present,
  }

  user { $::couchpotato::user_name:
    ensure           => present,
    comment          => 'Couchpotato daemon',
    groups           => $::couchpotato::group_name,
    home             => $::couchpotato::user_home,
    password         => '!',
    password_max_age => '-1',
    password_min_age => '-1',
    shell            => '/bin/false',
  }

  Group[ $::couchpotato::group_name ] ->
  User[ $::couchpotato::user_name ]
}
