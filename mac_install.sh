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
brew install python
brew install node

# Upgrade pip
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenvwrapper
pip install powerline-status
pip install ipython

# Install generic stuff
./install.sh

git config --global credential.helper osxkeychain

# Install mononoki font
cp ./mononoki-patched.ttf /Library/Fonts
