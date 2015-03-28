#sabnsbd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What couchpotato affects](#what-couchpotato-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with couchpotato](#beginning-with-couchpotato)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development](#development)

## Overview

Install CouchPotato on SLES 12.

## Module Description

This module installs, configures in a basic way and starts the CouchPotato service.

## Setup

### What couchpotato affects

Installs an RPM from a 3rd party yum repository.

Uses significant I/O and disk space to process downloaded Usenet binaries.

Opens selected ports on the system firewall.

### Setup Requirements **OPTIONAL**

This module pulls in many packages that may require custom repositories.

### Beginning with couchpotato

The very basic steps needed for a user to get the module up and running. 

## Usage

Include the module to use it.
```puppet
node couchpotato.example.net {
   include couchpotato
}
```

## Reference

Includes the standard install, config, service layout.

## Limitations

Limited to Puppet 3.0+.

Compatible with RedHat and Suse type Linux Operating Systems.

## Development

See [Waveclaw.net Software Repository](https://stash.waveclaw.net/projects/PUPPET/repos/couchpotato)

## Release Notes/Contributors/Etc

See CHANGELOG
