#!/bin/sh -ex

[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

xcode-select --install || true

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

git config --global credential.helper osxkeychain

# Install mononoki font
cp ./resources/mononoki-patched.ttf /Library/Fonts

# Install tldr.sh
npm install -g tldr

# Upgrade pip
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenvwrapper
pip install ipython
