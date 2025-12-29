#!/usr/bin/env bash

set -e

script_dir=$(cd $(dirname "${0}"); pwd)

mkdir -p "$HOME"/bin

rsync \
  --exclude ".DS_Store" \
  -avh --no-perms ${script_dir}/home/ ~;

rsync \
  --exclude ".DS_Store" \
  -avh --no-perms ${script_dir}/.config/ ~/.config;
