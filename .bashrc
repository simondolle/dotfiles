

#invite
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

BASIC_PROMPT="[\A \u@\h \W\$(parse_git_branch)] "
PS1=$BASIC_PROMPT

#color prompt works only on hosts that support color
USE_COLOR_PROMPT=0
if [ $(tput colors) ];then
  USE_COLOR_PROMPT=1
fi

if [ $TERM != xterm -a $TERM != xterm-256color ]; then
  USE_COLOR_PROMPT=0
fi

#color prompt in red in case of error
if [ $USE_COLOR_PROMPT -ne 0 ]; then
  BLACK_COLOR="\[\033[0m"
  RED_COLOR="\033[1;31m"
  export PROMPT_COMMAND='if (($? > 0)); then echo -ne "$RED_COLOR"; fi'; export PS1="$BASIC_PROMPT$BLACK_COLOR"
else
  unset PROMPT_COMMAND ; export PS1="$BASIC_PROMPT"
fi


#git autocomplete (not sure if necessary on windows)
source ~/.git-completion.sh

#aliases
alias ls='ls -G'
alias ll="ls -l"
alias grep='grep -i --color'

#history search
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
