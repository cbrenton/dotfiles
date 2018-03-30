#!/bin/sh -ex

# Force creation of info.sh
cp -n ./resources/info.template ./info.sh || true
vi ./info.sh || true

# Source info
. info.sh

# Run steps that require sudo.
./mac_sudo_install.sh

# Steps that require non-sudo. Used mostly for brew/pip packages.
brew_install() {
  brew install "$1" || true
}

# Install tools
for package in "reattach-to-user-namespace" \
  "git" \
  "vim" \
  "tmux" \
  "python" \
  "node" \
  "wget"; do
  brew_install "${package}"
done

# Install tldr.sh
npm install -g tldr

# Install generic stuff
./install.sh

# OSX-specific stuff
./osx
