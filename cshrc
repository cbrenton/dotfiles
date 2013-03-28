# Invoke the unified shell environment
csh_env

#set prompt = '%{\033[37m%}%m%{\033[31m%}:%{\033[34m%}%c%{\033[31m%}|%{\033[36m%}>%{\033[0m%} '
#set job_prompt = '"${pvtwhite}%m${pvtred}:${pvtblue}%c${pvtred}|${pvtcyan}>${pvtreset} "'

switch (`hostname`)
   case *.pdi.com:
      set site = 'RWC'
      breaksw
   case *.ddu-india.com:
      set site = 'DDU'
      breaksw
   case *:
      set site = 'GDI'
      breaksw
endsw

set job_cur_prompt = '"${pvtwhite}%m${pvtblue}@%B${pvtwhite}${site}%b${pvtred}:${pvtblue}%~${pvtred}|${pvtred}»${pvtreset} "'

set rprompt = '%P'
path_reset

setenv LS_COLORS 'no=00:fi=00:di=00;34:tw=1;36:ow=1;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'

bindkey "\e[3~" delete-char         # Delete
if ( { tty -s } ) stty erase '^?'   # for sys_key
bindkey ^R i-search-back 

set complete = enhance

source ~/.aliases

setenv DDU_HOST highpot
setenv GDI_HOST chaat
setenv RWC_HOST tamalpais

#if (`hostname` == "tamalpais.pdi.com") then
#   set job_cur_prompt = '"%B${pvtwhite}${site}%b:${pvtblue}%~${pvtred}|${pvtwhite}${pvtcyan}»${pvtreset} "'
#else
#   set job_cur_prompt = '"%B${pvtwhite}${site}%b:${pvtwhite}%m${pvtred}:${pvtblue}%~${pvtred}|${pvtwhite}${pvtcyan}»${pvtreset} "'
#endif
