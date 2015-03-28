# == Defined Type couchpotato::repo::zyp
#
# This class is called from couchpotato for setup of repos.
#
define couchpotato::repo::zyp {
    $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
    ensure_resource('zypprepo', $repo, { baseurl => $title })
}
