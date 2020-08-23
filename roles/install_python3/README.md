# mws.core.install\_python3

This role installs Python 3.

It is magic.
It requires only that you can connect to the inventory wth Ansible and that a POSIX-compatible shell is installed as `/bin/sh`.
Care has been taken in the construction of the installation script to make sure it doesn't rely on shell extensions outside of POSIX (i.e. it does not use any bash-specific syntax.)

This role has been developed with and tested against:

* Debian
* Fedora
* OpenBSD
* Raspberry Pi OS

## Usage

This role is most useful as part of a bootstrap playbook.
It _must_ be listed as the first and only role of the first play that runs commands on the inventory.
Fact gathering requires Python so it must be disabled during this play.
It can be re-enabled immediately after this role executes.

            ---
            - hosts: 'all'
              gather_facts: no
              environment:
                PATH: '/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
              vars:
                ansible_become_method: 'su'
                ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
              roles:
              - 'msamsonoff.core.install_python3'

            - hosts: 'all'
              roles:
              - 'some.other.role'

If you are using the `msamsonoff.core.openssh_sshd_config` role to change the SSH port you must use the `wait_for_ssh.yml` playbook before the `msamsonoff.core.install_python3` play.
(This comports with the rule above since the `wait_for_ssh.yml` delegates to `localhost` and does not actually run commands on the inventory.)

            ---
            - import_playbook: 'wait_for_ssh.yml'

            - hosts: 'all'
              gather_facts: no
              environment:
                PATH: '/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
              vars:
                ansible_become_method: 'su'
                ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
              roles:
              - 'msamsonoff.core.install_python3'

            - hosts: 'all'
              roles:
              - 'some.other.role'

## Variables

The role supports some additional configuration options for OpenBSD.
These variables have no effect on other platforms.

<dl>
  <dt><code>msamsonoff_core_install_python3_openbsd_pkg_path</code></dt>
  <dd>
    The <code>PKG_PATH</code> environment variable used for the <coe>pkg_add</code> command.
    The default is <code>cdn.openbsd.org</code>.
  </dd>
  <dt><code>msamsonoff_core_install_python3_openbsd_pkg_name</code></dt>
  <dd>
    The package name used for the <code>pkg_add</code> command.
    The default is <code>python%3.7</code>.
    This prevents <code>pkg_add</code> from failing due to ambiguity.
  </dd>
</dl>
