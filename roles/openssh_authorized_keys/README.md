# msamsonoff.core.openssh\_authorized\_keys

This role manages the Ansible user's `.ssh/authorized_keys` file.
It sets the entire contents of the `authorized_keys` file.
Only the keys in the files specified by the `msamsonoff_core_openssh_authorized_keys_files` variable will be included.
All other keys are removed.

This role has been developed with and tested against:

* Debian
* Fedora
* OpenBSD
* Raspberry Pi OS

⚠ _WARNING_: This role only makes a feeble attempt at protecting you from mistakes: it checks that there is at least one key file specified.
It does not check that your own key is listed.
It does not check that the key is valid or even well-formed.
It is quite possible to lock yourself out of a system if you make a mistake configuring this role.

## Usage

Include the role in your playbook.
It can be included in any playbook along with other roles, but it is helpful to have a dedicated `authorized_keys.yml` playbook that only runs this one role.

            ---
            - hosts: 'all'
              roles:
              - 'msamsonoff.core.openssh_authorized_keys'

Add to your project a folder that contains SSH public keys.
The default location for this folder is defined as

            ---
            msamsonoff_core_openssh_authorized_keys_folder: '{{ playbook_dir }}/../ssh'

With this default, your project's folder structure might look like this:

            example-project/
              ansible/
                playbook.yml
              ssh/
                alice/
                  id_ed25519.pub
                bob/
                  id_rsa.pub

Set the `msamsonoff_core_openssh_authorized_keys_files` variable to list the paths of the key files relative to the `msamsonoff_core_openssh_authorized_keys_folder`.

            --
            msamsonoff_core_openssh_authorized_keys_files:
            - 'alice/id_ed25519.pub'
            - 'bob/id_rsa.pub'

You can configure fine-grained access control by setting this variable to different values between different inventory hosts and groups.

## Variables

<dl>
  <dt><code>msamsonoff_core_openssh_authorized_keys_folder</code></dt>
  <dd>
    This variable sets the folder that contains SSH keys.
    The default value is <code>'{{ playbook_dir }}/../ssh'</code>.
  </dd>
  <dt><code>msamsonoff_core_openssh_authorized_keys_files</code></dt>
  <dd>
    This variable sets the list of SSH key files.
    This variable is mandatory.
    There is no default value and the role will fail if it is not defined.
  </dd>
</dl>
