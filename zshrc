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

OMZDIR=".oh-my-zsh"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/$OMZDIR

autoload omz

plugins=(archlinux git tmux)

zstyle ':omz:plugins:*' autostart on
# Comment out the following line if you wish for every z shell.
zstyle :omz:plugins:tmux autostart off
# cmd, t irc will launch irssi inside a tmux session named irc.
zstyle :omz:plugins:tmux:cmd irc irssi
# dir, t code will launch a shell inside of tmux in $HOME/code.
zstyle :omz:plugins:tmux:dir code $HOME/code

export MYVIMRC=~/.vimrc
export PATH=$PATH
export EDITOR=vim
export GIT_EDITOR=vim

# Set name of the theme to load.
# Look in $HOME/.omz/themes/ or $HOME/.oh-my-zsh/themes.
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mine"

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

# Customize to your needs...
# OS X only.
if [ $OS = "osx" ]
then
   export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
fi

# Exclude directories from gfind queries.
export GFIND_EXCLUDE="3P:Deprecated"

# Todo-txt will use the ls command if no command is specified.
export TODOTXT_DEFAULT_ACTION=ls

alias zed="vim $HOME/.zshrc"
alias rez="source $HOME/.zshrc"
alias ved="vim $HOME/.vimrc"
alias xed="vim $HOME/.Xresources"
alias rex="xrdb $HOME/.Xresources"
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias pingu="ping -c 4 www.google.com"
alias ll='ls -lh'
alias la='ls -lhA'
alias l='ls'
alias cl='clear'
alias x='exit'
#alias q='exit'

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
