#!/usr/bin/env bash

set -e

script_dir=$(cd $(dirname "${0}"); pwd)

brew bundle install --file=${script_dir}/Brewfile
brew bundle cleanup --file=${script_dir}/Brewfile
