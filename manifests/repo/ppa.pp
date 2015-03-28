# == Defined Type couchpotato::repo::ppa
#
# This class is called from couchpotato for setup of repos.
#
define couchpotato::repo::ppa {
  $repo = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('apt::source', $repo,
    {'ensure' => 'present', 'location' => $title, 'repos' => 'main' })
}
