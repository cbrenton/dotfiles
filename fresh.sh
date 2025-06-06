#!/bin/sh

echo "Setting up your Mac..."

# Force creation of info.sh
cp -n ./info.template ./info.sh || true
vi ./info.sh || true

# Git config
. git.sh

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Install omz theme
file=$HOME/.dotfiles/cbr.zsh-theme
target=$HOME/.oh-my-zsh/themes/cbr.zsh-theme
ln -s "$file" "$target"
echo "Linked $file → $target"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

DOTFILES_DIR="$HOME/.dotfiles/configs"
TARGET_DIR="$HOME"

shopt -s nullglob dotglob  # dotglob includes hidden files

# Symlink config files
sh ./replace.sh

echo "TODO: nvim config"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

curl -sSL https://get.rvm.io | bash

# Create a projects directories
mkdir $HOME/code

# Create Code subdirectories
mkdir $HOME/code/junk

# Symlink the Mackup config file to the home directory
ln -s ./.mackup.cfg $HOME/.mackup.cfg

[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

xcode-select --install || true

git config --global credential.helper osxkeychain

# Set macOS preferences - we will run this last because this will reload the shell
. ./.macos
