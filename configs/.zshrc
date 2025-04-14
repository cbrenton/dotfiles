################
# OS detection #
################

case $OSTYPE in
   darwin*)
      # Mac.
      OS="osx"
      ;;
   linux-gnu)
      if [ -f /etc/arch-release ]
      then
         OS="arch"
      elif [ -f /etc/debian_version ]
      then
         OS="debian"
      elif [ -f /etc/redhat-release ]
      then
         OS="redhat"
      fi
      command -v "lsb_release" >/dev/null && OS=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
      ;;
esac

#######
# OMZ #
#######

OMZDIR=".oh-my-zsh"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/$OMZDIR

autoload omz

plugins=(git tmux)

zstyle ':omz:plugins:*' autostart on
# Comment out the following line if you wish for every z shell.
zstyle :omz:plugins:tmux autostart off
# cmd, t irc will launch irssi inside a tmux session named irc.
zstyle :omz:plugins:tmux:cmd irc irssi
# dir, t code will launch a shell inside of tmux in $HOME/code.
zstyle :omz:plugins:tmux:dir code $HOME/code

# Look in $HOME/.omz/themes/ or $HOME/.oh-my-zsh/themes.
ZSH_THEME="cbr"

# Initialize oh-my-zsh.
source $ZSH/oh-my-zsh.sh

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

################
# GENERAL/PATH #
################

# Homebrew python first
export PATH="/opt/homebrew/bin/python3:$PATH"

if [ $OS = "osx" ]
then
   export PATH=$PATH:/opt/local/bin
   export PATH=$PATH:/opt/local/sbin
   export PATH=$PATH:/usr/local/bin
   export PATH=$PATH:/usr/bin
   export PATH=$PATH:/bin
   export PATH=$PATH:/usr/sbin
   export PATH=$PATH:/usr/local/sbin
   export PATH=$PATH:/sbin
   export PATH=$PATH:/usr/X11/bin
   # export PATH=/usr/local/opt/llvm@9/bin:$PATH
   export CPATH=`xcrun --show-sdk-path`/usr/include
fi

export PATH=$PATH:/usr/local/opt/ccache/libexec
export PATH=$PATH:/Library/TeX/texbin

export EDITOR=nvim
export GIT_EDITOR=nvim

autoload -U compinit
compinit

# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

##########
# GOLANG #
##########

export GOPATH=$HOME/go
export GOROOT=$(brew --prefix golang)/libexec
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin

###########
# ALIASES #
###########

source $HOME/.aliases
if [[ -e $HOME/.workaliases ]]; then
   source $HOME/.workaliases
fi

####################
# CUSTOM FUNCTIONS #
####################

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
## ARCHIVE EXTRACTOR #{{{
extract() {
   local c e i

   (($#)) || return

   for i; do
      c=''
      e=1
      if [[ ! -r $i ]]; then
         echo "$0: file is unreadable: \`$i'" >&2
         continue
      fi
      case $i in
         *.tar.bz2 ) tar xvjf $1 ;;
         *.tar.gz ) tar xvzf $1 ;;
         *.tar.xz ) tar xvJf $1 ;;
         *.tar ) tar xvf $1 ;;
         *.tbz2 ) tar xvjf $1 ;;
         *.tgz ) tar xvzf $1 ;;
         *.rar ) unrar x $1 ;;
         *.gz ) gunzip $1 ;;
         *.bz2 ) bunzip2 $1 ;;
         *.zip ) unzip $1 ;;
         *.Z ) uncompress $1 ;;
         *.7z ) 7z x $1 ;;
         *.xz ) unxz $1 ;;
         *.exe ) cabextract $1 ;;
         * ) echo "$0: unrecognized file extension: \`$i'" >&2
         continue;;
   esac
   command $c "$i"
   e=$?З
done
return $e
}

#######################
# SSH REAUTH FOR TMUX #
#######################

if [ "x$SSH_AUTH_SOCK" != "x/tmp/$USER-ssh-auth-sock" ]; then
    ln -snf $SSH_AUTH_SOCK /tmp/$USER-ssh-auth-sock
fi
 
SSH_AUTH_SOCK=/tmp/$USER-ssh-auth-sock
export SSH_AUTH_SOCK
 
# Find an active auth socket
# When the above fails, run this first on your screen host and then again on the remote
# see http://tychoish.com/rhizome/9-awesome-ssh-tricks/
ssh-reagent ()
{
    for agent in /tmp/ssh-*/agent.*;
    do
        export SSH_AUTH_SOCK=$agent;
        if ssh-add -l 2>&1 > /dev/null; then
            echo Found working SSH Agent:;
            ssh-add -l;
            ln -snf $SSH_AUTH_SOCK /tmp/$USER-ssh-auth-sock;
            export SSH_AUTH_SOCK=/tmp/$USER-ssh-auth-sock;
            return;
        fi;
    done;
 
 
    echo 'Cannot find ssh agent - maybe you should reconnect and forward it?' 1>&2
}
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
