# ubuntuAnsible
Ansible for setting up Ubuntu machines. Modified from here: https://gitlab.com/radek-sprta/ansible-personal

## Usage

### Pre-playbook
1. Check tasks and make sure all links are updated.
    1. vdh - desktop//install-debs.yml
    2. filezillaPro - common//install-w-shell.yml

### Running the playbook
`wget -qO- https://raw.githubusercontent.com/siraht/ubuntuAnsible/main/run.sh | bash`

or to just run the playbook itself after installing dependencies:

`ansible-playbook --inventory localhost, setup.yml --ask-become-pass`

### Post-playbook
1. Setup tmux
    - vim .tmux.conf.local
        - tmux_conf_copy_to_os_clipboard=true
        - enable all tpm plugins
    - Add keyboard shortcut with following commands:
        - gnome-terminal -e "tmux-attach"
2. Setup Tailscale
    - `sudo tailscale up --accept-routes`
3. Sign into Firefox
4. Connect to netdata
    - https://app.netdata.cloud
5. Add SSH key to GitHub
6. Add new machine to Portainer host
7. Edit nohang config
    - /etc/nohang/nohang-desktop.conf
8. Setup all other programs

## To-Do
- Finish adding programs
- Add mailspring .deb
- Modify for Regolith/i3
- Add tmux setup
- Add Firefox profile restoration

## Bugs
1. On 22.04 Pop_OS I had to run it with `ansible-playbook --inventory localhost, ~/configuration/setup.yml --ask-become-pass -e ansible_python_interpreter=/usr/bin/python3`
2. Docker post-installation commands still hang
3. auto-cpufreq script is hanging
