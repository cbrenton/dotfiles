# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export PATH=$PATH:/usr/local/bin/reddit-cli

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mine"
#ZSH_THEME="random"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' hosts off
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

# My code directory.
export MY_CODE_DIR=/home/chris/Code
# Exclude directories from gfind queries.
export GFIND_EXCLUDE="3P:Deprecated"

# Use -j 3 by default for make with homebrew.
export HOMEBREW_MAKE_JOBS=3

# Todo-txt will use the ls command if no command is specified.
export TODOTXT_DEFAULT_ACTION=ls

alias sup="updateCodeDirs.sh"
alias c="ssh cbrenton@cominor.com"
alias vogon="ssh cbrenton@vogon.csc.calpoly.edu"
alias reddit-cli=" reddit-cli"
alias t="todo.sh -d ~/.todo/todo.cfg"
alias rez="source ~/.zshrc"
alias zed="vim ~/.zshrc"
alias pingu="ping -c 4 www.google.com"
#alias vim="nocorrect vim"
#alias sudo="sudo "
alias sudo="nocorrect sudo"
alias ll='ls -lh'
alias la='ls -lhA'
alias l='ls'
alias cl='clear'
alias x='exit'
alias q='exit'


notes()
{
   if [[ $# -eq 1 ]]; then
      if [[ ! -d ~/Documents/$1 ]]; then
         echo "Directory $1 does not exist."
      else
         # If notes.txt exists, add a newline before inserting the date.
         if [[ -f ~/Documents/$1/notes.txt ]]; then
            echo >> ~/Documents/$1/notes.txt
         fi
         date "+%Y-%m-%d" | boxes -d shell >> ~/Documents/$1/notes.txt
         echo >> ~/Documents/$1/notes.txt
         vim ~/Documents/$1/notes.txt
      fi
   else
      # If notes.txt exists, add a newline before inserting the date.
      if [[ -f ./notes.txt ]]; then
         echo >> ./notes.txt
      fi
      date "+%Y-%m-%d" | boxes -d shell >> notes.txt
      echo >> notes.txt
      vim notes.txt
   fi
}

review()
{
   if [[ $# -eq 1 ]]; then
      if [[ ! -d ~/Documents/$1 ]]; then
         echo "Directory $1 does not exist."
      else
         vim ~/Documents/$1/notes.txt
      fi
   else
      # If notes.txt exists, edit it.
      if [[ -f ./notes.txt ]]; then
         vim ./notes.txt
      fi
   fi
}
