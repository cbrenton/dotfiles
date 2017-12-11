#!/bin/sh -ex

[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

xcode-select --install || true

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true

git config --global credential.helper osxkeychain

# Install mononoki font
cp ./resources/mononoki-patched.ttf /Library/Fonts

# Upgrade pip
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenv
pip install virtualenvwrapper
pip install ipython
