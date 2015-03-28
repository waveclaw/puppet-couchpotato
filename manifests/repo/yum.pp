# == Defined Type couchpotato::repo::yum
#
# This class is called from couchpotato for setup of yum.
#
define couchpotato::repo::yum {
  $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
  ensure_resource('yumrepo', $repo,
    {'ensure' => 'present', 'baseurl' => $title })
}
