#!/bin/bash

# Set various shell options to make script execution more strict.
# See http://kvz.io/blog/2013/11/21/bash-best-practices/.
set -o errexit
set -o nounset
set -o pipefail

# Directories.
readonly ROOT_DIR=$(readlink --canonicalize "$(dirname "${BASH_SOURCE[0]}")/..")
readonly CONFIG_DIR="${ROOT_DIR}/config"
readonly VIRTUALENV="${ROOT_DIR}/venv"

# Configuration.
readonly ACCOUNTS_CSV="${CONFIG_DIR}/accounts.csv"

function setup_virtualenv() {
  if ! test -d "${VIRTUALENV}"; then
    echo "Creating virtualenv..."
    virtualenv "${VIRTUALENV}"
  fi

  # TODO: We need to temporarily disable `nounset` whilst activating the
  # virtualenv. See https://github.com/pypa/virtualenv/pull/922.
  echo "Activating virtualenv..."
  set +o nounset
  source "${VIRTUALENV}/bin/activate"
  set -o nounset
}

setup_virtualenv
