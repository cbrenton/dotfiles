xcode-select --install

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install tools
brew install reattach-to-user-namespace
brew install git
brew install vim
brew install tmux

# Install generic stuff
./install.sh

git config --global credential.helper osxkeychain
