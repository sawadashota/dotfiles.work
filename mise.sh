#!/usr/bin/env bash

set -e

mise install nodejs@latest
mise use -g --pin nodejs@latest
npm install --global corepack@latest
mise install python@latest
mise use -g --pin python@latest
mise install rust@latest
mise use -g --pin rust@latest
