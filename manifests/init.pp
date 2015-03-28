# == Class: couchpotato
#
# Full description of class couchpotato here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class couchpotato (
) {
  class { '::couchpotato::repo': } ->
  class { '::couchpotato::install': } ->
  class { '::couchpotato::config': } ~>
  class { '::couchpotato::service': } ->
  Class['::couchpotato']
}
