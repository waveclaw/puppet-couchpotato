# == Class couchpotato::repo
#
# This class is called from couchpotato for setup of repos.
#
class couchpotato::repo(
  $repos = hiera('couchpotato::repo::repos', $::couchpotato::defaults::repos),
) inherits couchpotato::defaults {
  case $::osfamily {
    'Debian': {
      couchpotato::repo::ppa { [$repos]: }
    }
    'RedHat': {
      couchpotato::repo::yum { [$repos]: }
    }
    'Suse': {
      couchpotato::repo::zyp { [$repos]: }
    }
    default: { }
  }
}
