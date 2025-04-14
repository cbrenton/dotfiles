#!/bin/sh

echo "Setting up your Mac..."

# Force creation of info.sh
cp -n ./resources/info.template ./info.sh || true
vi ./info.sh || true

# Source info
. info.sh

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

DOTFILES_DIR="$HOME/.dotfiles/configs"
TARGET_DIR="$HOME"

shopt -s nullglob dotglob  # dotglob includes hidden files

for file in "$DOTFILES_DIR"/.*; do
  filename=$(basename "$file")

  # skip . and ..
  [[ "$filename" == "." || "$filename" == ".." ]] && continue

  target="$TARGET_DIR/$filename"

  # Backup if needed
  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "Backing up $target to $target.backup"
    mv "$target" "$target.backup"
  fi

  # Remove existing symlink
  if [[ -L "$target" ]]; then
    rm "$target"
  fi

  ln -s "$file" "$target"
  echo "Linked $file → $target"
done

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
source ./.macos
