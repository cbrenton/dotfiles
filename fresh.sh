#!/bin/sh

echo "Setting up your Mac..."

# Force creation of info.sh
cp -n ./info.template ./scripts/info.sh || true
vi ./scripts/info.sh || true

# Git config
. scripts/git.sh

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
sh ./scripts/replace.sh

echo "TODO: nvim config"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# Confirm Brewfiles exist
COMMON="Brewfile.common"
WORK="Brewfile.work"
PERSONAL="Brewfile.personal"

for f in "$COMMON" "$WORK" "$PERSONAL"; do
  if [[ ! -f "$f" ]]; then
    echo "Warning: $f not found in $(pwd)"
  fi
done

echo "Select mode:"
echo "  1) Personal"
echo "  2) Work"

choice=""
while [[ -z "${choice:-}" ]]; do
  read -rp "Enter your choice: " input
  case "${input:-}" in
    1) choice="personal";;
    2) choice="work";;
    *) echo "Invalid selection. Please enter 1 or 2.";;
  esac
done

echo "Running 'brew bundle' for common packages..."
brew bundle --file="$COMMON"
if [[ "$choice" == "work" ]]; then
  echo "Running 'brew bundle' for WORK packages..."
  brew bundle --file="$WORK"
else
  echo "Running 'brew bundle' for PERSONAL packages..."
  brew bundle --file="$PERSONAL"
fi

# Linux
VSCODE_DIR="$HOME/.config/Code/User"
# macOS
if [[ "$(uname)" == "Darwin" ]]; then
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
fi
KEYBINDINGS="$VSCODE_DIR/keybindings.json"

# Write new keybindings
cat > "$KEYBINDINGS" <<'EOF'
[
  {
    "key": "ctrl+tab",
    "command": "workbench.action.nextEditor"
  },
  {
    "key": "ctrl+shift+tab",
    "command": "workbench.action.previousEditor"
  }
]
EOF

curl -sSL https://get.rvm.io | bash

# Create a projects directory
mkdir -p $HOME/code/junk
mkdir -p $HOME/media/tv $HOME/media/movies

[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

git config --global credential.helper osxkeychain

# Set macOS preferences - we will run this last because this will reload the shell
. ./.macos
