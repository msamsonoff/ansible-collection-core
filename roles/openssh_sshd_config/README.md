# msamsonoff.core.openssh\_sshd\_config

This role installs an opinionated configuration for OpenSSH.
The configuration is based on:

* [https://infosec.mozilla.org/guidelines/openssh](https://infosec.mozilla.org/guidelines/openssh)
* [https://stribika.github.io/2015/01/04/secure-secure-shell.html](https://stribika.github.io/2015/01/04/secure-secure-shell.html)

This role also lets you change the SSH port.
This does not offer any increased security, but it does eliminate a tremendous amount of log spam.
Sometimes this role can successfully change the port, restart SSH, and re-establish the Ansible connection.
Sometimes it cannot.
¯\\\_(ツ)\_/¯

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
              - 'msamsonoff.core.openssh_sshd_config'

### Changing the Port

⚠ _WARNING_: THIS OFFERS NO INCREASE IN SECURITY.

Set the `msamsonoff_core_openssh_sshd_config_port` variable to some other value.
Use a random number between 1024 and 65535 that isn't some other common service port.

            ---
            msamsonoff_core_openssh_sshd_config_port: '12345'

You can create a shared `wait_for_ssh.yml` playbook to account for when the port has been changed and when it has not been changed yet.

            ---
            - hosts: 'all'
              gather_facts: no
              tasks:
              - set_fact:
                  msamsonoff_core_openssh_sshd_config_port: '{{ ansible_port|default(22) }}'
                when: |
                  msamsonoff_core_openssh_sshd_config_port is not defined
              - delegate_to: 'localhost'
                wait_for:
                  host: '{{ hostvars[inventory_hostname]["ansible_host"]|default(inventory_hostname) }}'
                  port: '{{ ansible_port|default(22) }}'
                  timeout: 10
                ignore_errors: yes
                register: register_wait_for_ssh
              - set_fact:
                  ansible_port: 22
                when: |
                  register_wait_for_ssh.failed
              - delegate_to: 'localhost'
                wait_for:
                  host: '{{ hostvars[inventory_hostname]["ansible_host"]|default(inventory_hostname) }}'
                  port: '{{ ansible_port }}'
                  timeout: 10
                when: |
                  register_wait_for_ssh.failed

Include this `wait_for_ssh.yml` playbook at the top of your other playbooks.
It must run before any other plays that connect to the inventory (including before `msamsonoff.core.install_python3`.)

            ---
            - import_playbook: 'wait_for_ssh.yml'

            - hosts: 'all'
              roles:
              - 'msamsonoff.core.openssh_sshd_config'
              - 'some.other.role'

## Variables

<dl>
  <dt><code>msamsonoff_core_openssh_sshd_config_port</code></dt>
  <dd>The port on which OpenSSH listens. The default is <code>22</code>.</dd>
</dl>
