export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
unset LC_ALL
: ${rvm_path:="$HOME/.rvm"}
[[ -s "$rvm_path/contrib/ps1_functions" ]] &&
  source "$rvm_path/contrib/ps1_functions"
ps1_set --prompt ∴
PATH="$HOME/Library/Python/2.7/bin:$PATH"
#. /Users/derek/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
#function _update_ps1() {
#  export PS1="$(~/bin/powerline-shell.py $?)"
#}
#
#export PROMPT_COMMAND="_update_ps1"
PATH="/usr/local/heroku/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin
alias such=git
alias very=git
alias wow='git status'

function fuck() {
  killall -9 $2;
  if [ $? == 0 ]
  then
    echo
    echo " (╯°□°）╯︵$(echo $2|flip &2>/dev/null)"
    echo
  fi
}

export PATH="~/bin:$PATH"

alias aneditor=vim
alias yavascript=node
alias rubby=ruby

fortune -n 160 | cowsay
