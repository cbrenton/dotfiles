#!/bin/sh -ex

[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

xcode-select --install || true

git config --global credential.helper osxkeychain

# Install mononoki font
cp ./resources/mononoki-patched.ttf /Library/Fonts

# Upgrade pip
# pip install --upgrade distribute
# pip install --upgrade pip
# pip install virtualenv
# pip install virtualenvwrapper
# pip install ipython

pip3 install --upgrade distribute
pip3 install --upgrade pip
pip3 install virtualenv
pip3 install virtualenvwrapper
pip3 install ipython
