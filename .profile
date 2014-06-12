source '/usr/local/share/chruby/chruby.sh'
source '/usr/local/share/chruby/auto.sh'

#chruby 2.1.2
chruby 2.0.0-p353

export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
export PATH="~/bin:$PATH"
#export PATH='/usr/local/bin:$PATH'

source '/usr/local/Cellar/git/1.9.3/etc/bash_completion.d/git-prompt.sh'
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PROMPT_COMMAND='__git_ps1 "\u@\h:\w \[\e[0;31m\]$(__ruby_version)\[\e[0m\]" "\n∴ "'
#[ "$PS1" ] && PS1="\n(\$(__ruby_version))\$(__git_ps1 ' (%s)') \n$PS1"

__ruby_version() {
  [ "$RUBY_VERSION" ] || sys='system: '
  ver=$(ruby -v 2>/dev/null | awk '{print $1"-"$2}')
  echo "$sys${ver:-none}"
}

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

alias aneditor=vim
alias yavascript=node
alias rubby=ruby

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
  fortune -n 160 | cowsay
fi
