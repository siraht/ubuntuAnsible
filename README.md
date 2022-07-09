# ubuntuAnsible
Ansible for setting up Ubuntu machines. Modified from here: https://gitlab.com/radek-sprta/ansible-personal

## Pre-playbook
1. Check tasks and make sure all links are updated.
    1. vdh - desktop//install-debs.yml
    2. filezillaPro - common//install-w-shell.yml

## Running the playbook
`wget -qO- https://raw.githubusercontent.com/siraht/ubuntuAnsible/main/run.sh | bash`

or to just run the playbook itself after installing dependencies:

`ansible-playbook --inventory localhost, setup.yml --ask-become-pass`

## Post-playbook
1. Setup tailscale: `sudo tailscale up --accept-routes`
2.