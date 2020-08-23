# msamsonoff.core.install\_python3\_virtualenv

This role installs `virtualenv` for Python 3.
This allows you to use the `virtualenv` parameter for Ansible's `pip` module.

This role has been developed with and tested against:

* Debian
* Fedora
* Raspberry Pi OS

## Usage

Include this role in your playbook.

            ---
            - hosts: 'all'
              roles:
              - 'msamsonoff.core.install_python3_virtualenv'
              - 'some.other.role'
