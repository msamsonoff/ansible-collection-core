# msamsonoff.core.openssh\_passwordauthentication\_no

This role disables password authentication for OpenSSH.
It makes no other changes to the OpenSSH configuration.

This role has been developed with and tested against:

* Debian
* Fedora
* OpenBSD
* Raspberry Pi OS

## Usage

Include this role in your playbook.

            ---
            - hosts: 'all'
              roles:
              - 'msamsonoff.core.openssh_passwordauthentication_no'
              - 'some.other.role'
