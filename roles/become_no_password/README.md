# msamsonoff.core.become\_no\_password

This role allows Ansible to `become` root without a password.

This role is usually used with physical or non-cloud virtual servers (e.g. VMware ESXi.)
It is not necessary for cloud-based images (e.g. AWS AMIs) since they generally have `sudo` configured so that it doesn't require a password.
It is, however, harmless to run it against such cloud-based images.

This role has been developed with and tested against:

* Debian
* Fedora
* OpenBSD
* Raspberry Pi OS

## Usage

This role is most useful as part of a bootstrap playbook.

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
              environment:
                PATH: '/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
              vars:
                ansible_become_method: 'su'
                ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
              roles:
              - 'msamsonoff.core.install_sudo'
              - 'msamsonoff.core.become_no_password'
              - 'msamsonoff.core.openssh_authorized_keys'
              - 'msamsonoff.core.openssh_passwordauthentication_no'

Run the bootstrap playbook with the `-k` and `-K` arguments and enter the user and root passwords.

            $ ansible-playbook -k -K bootstrap.yml
