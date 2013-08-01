export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
unset LC_ALL
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/contrib/ps1_functions" ]] &&
  source "$HOME/.rvm/contrib/ps1_functions"
ps1_set --prompt ∴
PATH="$HOME/Library/Python/2.7/bin:$PATH"
#. /Users/derek/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
#function _update_ps1() {
#  export PS1="$(~/bin/powerline-shell.py $?)"
#}
#
#export PROMPT_COMMAND="_update_ps1"
PATH="/usr/local/heroku/bin:$PATH"
