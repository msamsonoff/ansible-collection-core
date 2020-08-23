# msamsonoff.core

This collection contains a basic set of roles for managing inventory with Ansible.

<dl>
  <dt><a href="roles/become_no_password">become_no_password</a></dt>
  <dd>Allows Ansible to <code>become</code> root without a password</dd>

  <dt><a href="roles/install_python3">install_python3</a></dt>
  <dd>Installs Python 3</dd>

  <dt><a href="roles/install_python3_virtualenv">install_python3_virtualenv</a></dt>
  <dd>Installs <code>virtualenv</code> for Python 3</dd>

  <dt><a href="roles/install_sudo">install_sudo</a></dt>
  <dd>Installs <code>sudo</code></dd>

  <dt><a href="roles/openssh_authorized_keys">openssh_authorized_keys</a></dt>
  <dd>Manages the Ansible user's <code>.ssh/authorized_keys</code> file</dd>

  <dt><a href="roles/openssh_passwordauthentication_no">openssh_passwordauthentication_no</a></dt>
  <dd>Disables password authentication for OpenSSH</dd>

  <dt><a href="roles/openssh_sshd_config">openssh_sshd_config</a></dt>
  <dd>Opinionated configuration for OpenSSH</dd>
</dl>

This collection has been developed with and tested against:

* Debian
* Fedora
* OpenBSD
* Raspberry Pi OS
