#! /usr/bin/env bash

# Install script for my personal Ansible playbook
#
# Author: Radek Sprta

# Stop unpredictible behavior
set -o errexit          # Exit on most errors
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline

# Define constants
readonly PROJECTS_DIR="configuration"
readonly PLAYBOOK_REPO="https://github.com/siraht/ubuntuAnsible.git"
readonly PLAYBOOK="setup.yml"

# Display error message
function error() {
     echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# Check if binary is present
function check_binary() {
    if [[ $# -ne 1 && $# -ne 2 ]]; then
        error "Invalid arguments passed to check_binary()!"
    fi
    if ! command -v "$1" > /dev/null 2>&1; then
        error "Command not found: $1"
        return 1
    fi
    return 0
}

# Return the installation command based on the system
function get_packager() {
    if check_binary "apt"; then
        echo apt
        return 0
    elif check_binary "zypper"; then
        echo zypper
        return 0
    fi
    return 1
}

function main() {
    # Get the right install command
    readonly packager=$(get_packager)

    # Install libyaml for better Ansible performance
    if [[ "${packager}" == apt ]]; then
        eval "sudo ${packager} install -y libyaml-dev"
    else
        eval "sudo ${packager} install -y libyaml-devel"
    fi

    # Install Git and Ansible
    eval "sudo ${packager} install -y git ansible"

    # Clone the Ansible playbook and run it
    cd "${HOME}"
    mkdir -p "${PROJECTS_DIR}"
    git clone "${PLAYBOOK_REPO}" "${PROJECTS_DIR}"
    #ansible-galaxy install -r "${PROJECTS_DIR}/requirements.yml"
    ansible-playbook -i localhost, "${PROJECTS_DIR}/${PLAYBOOK}" --ask-become-pass

}

# Run the script
main "$@"

# vim: syntax=sh cc=80 tw=79 ts=4 sw=4 sts=4 et sr
