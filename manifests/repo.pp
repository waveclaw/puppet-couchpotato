# == Class couchpotato::repo
#
# This class is called from couchpotato for setup of repos.
#
class couchpotato::repo(
) {
  $_repo = $couchpotato::repo_name
  if $_repo != undef {
    case $::osfamily {
      'Debian': {
        couchpotato::repo::ppa { $_repo: }
      }
      'RedHat': {
        couchpotato::repo::yum { $_repo: }
      }
      'Suse': {
        couchpotato::repo::zyp { $_repo: }
      }
      default: { }
    }
  }
}
