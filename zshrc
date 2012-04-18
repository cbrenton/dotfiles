autoload omz

plugins=(archlinux git tmux)

zstyle :omz:style theme mine
zstyle ':omz:plugins:*' autostart on
# Comment out the following line if you wish for every z shell.
zstyle :omz:plugins:tmux autostart off
# cmd, t irc will launch irssi inside a tmux session named irc.
zstyle :omz:plugins:tmux:cmd irc irssi
# dir, t code will launch a shell inside of tmux in $HOME/code.
zstyle :omz:plugins:tmux:dir code $HOME/code

omz init

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.omz

export PATH=$PATH
export EDITOR=vim
export GIT_EDITOR=vim

# Set name of the theme to load.
# Look in $HOME/.omz/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mine"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' hosts off
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

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

# Customize to your needs...
# TODO: OS X only?
#export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# Exclude directories from gfind queries.
export GFIND_EXCLUDE="3P:Deprecated"

# Todo-txt will use the ls command if no command is specified.
export TODOTXT_DEFAULT_ACTION=ls

alias vogon="ssh cbrenton@unix1.csc.calpoly.edu"
alias reddit-cli=" reddit-cli"
alias t="todo.sh -d $HOME/.todo/todo.cfg"
alias zed="vim $HOME/.zshrc"
alias rez="source $HOME/.zshrc"
alias ved="vim $HOME/.vimrc"
alias xed="vim $HOME/.Xresources"
alias rex="xrdb $HOME/.Xresources"
alias pingu="ping -c 4 www.google.com"
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
      if [[ ! -d $HOME/Documents/$1 ]]; then
         echo "Directory $1 does not exist."
      else
         # If notes.txt exists, add a newline before inserting the date.
         if [[ -f $HOME/Documents/$1/notes.txt ]]; then
            echo >> $HOME/Documents/$1/notes.txt
         fi
         date "+%Y-%m-%d" | boxes -d shell >> $HOME/Documents/$1/notes.txt
         echo >> $HOME/Documents/$1/notes.txt
         vim $HOME/Documents/$1/notes.txt
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
      if [[ ! -d $HOME/Documents/$1 ]]; then
         echo "Directory $1 does not exist."
      else
         vim $HOME/Documents/$1/notes.txt
      fi
   else
      # If notes.txt exists, edit it.
      if [[ -f ./notes.txt ]]; then
         vim ./notes.txt
      fi
   fi
}
