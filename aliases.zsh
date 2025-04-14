alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias aed="vim $HOME/.dotfiles/aliases.zsh"
alias zed="vim $HOME/.zshrc"
alias rez="source $HOME/.zshrc"
alias ved="vim $HOME/.vimrc"
alias xed="vim $HOME/.Xresources"
alias rex="xrdb $HOME/.Xresources"
alias ted="vim $HOME/.tmux.conf"
alias ret="tmux source-file $HOME/.tmux.conf"
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias pingu="ping -c 4 www.google.com"
alias sudo="nocorrect sudo"
alias xinit="nocorrect xinit"
alias ll='ls -lh'
alias la='ls -lhA'
alias l='ls'
alias cl='clear'
alias x='exit'
alias vim='nvim'
alias v='vim'
alias t='tmux'
alias ta='tmux attach'
alias tn='tmux new'
alias sctl='sudo systemctl'
alias denko='echo "(´･ω･\`)" | pbcopy'
alias cry='echo "༼;´༎ຶ ۝ ༎ຶ༽" | pbcopy'
alias shrug='echo "¯\_(ツ)_/¯" | pbcopy'
alias hmm='echo "(Ծ‸ Ծ)" | pbcopy'
alias tf='terraform'

mkvirtualenv3() {mkvirtualenv $* -p `which python3`}
alias mkve='mkvirtualenv'
alias rmve='rmvirtualenv'
alias mkve3='mkvirtualenv3'
alias wo='workon'

alias gcn='git commit -a'
alias gca='git commit --amend -a'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdd='git diff origin/master'
alias gdl='git diff HEAD^'
alias grb='git rebase'
# Undo git commit amend
alias gua='git reset --soft @{1} && git commit -C @{1}'
alias lg='git lg'
alias nuke='git clean -df && git reset --hard'

alias scp='scp -pr'
alias mkdir='mkdir -p'

create_ssh_key() {[ $# -eq 1 ] && ssh-keygen -t rsa -b 4096 -C "$1" || { echo "Usage: create_ssh_key <email>" && return 1 }}

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

rg() { grep $* ./* -r --exclude-dir=build}
rf() { find . -name "$*" }
