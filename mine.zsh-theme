# Yay! High voltage and arrows!

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

BAT_CHARGE='/bin/batcharge.py'

function battery_charge {
   if [ ! $OSTYPE = 'linux-gnu' ]
   then
      `$BAT_CHARGE` 2>/dev/null
   fi
}

# ⁖ ⁘ ⁙ ⁛ ⁜ ∵ ∷
# ⊕ ⊖ ⊗ ⊘ ⊙ ⊚ ⊛ ⊜ ⊝ ⊞ ⊟ ⊠ ⊡
# ■ □ ◆ ◇ ○ ● ◻ ◼ ⟴
# ᄃ ᄄ ᄅ ᄆ ᄇ
# ᔦ ᔨ ᔪ ᔭ ᕒ ᚛ ᚜ 
PROMPT='%{$fg[white]%}%m%{$fg[red]%}:%{$fg[blue]%}%1~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[white]%}∴%{$reset_color%} '
#PROMPT='%{$fg[white]%}%m%{$fg[red]%}:%{$fg[blue]%}%1~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[white]%}λ%{$reset_color%} '
RPROMPT='$(battery_charge)'
#PROMPT='%{$fg[cyan]%}%1~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}∴%{$reset_color%} '
