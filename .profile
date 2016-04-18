## if Socket file doesn't exist, launch Postgres.app
#if [ ! -S "/tmp/.s.PGSQL.5432" ]; then
#  echo "Launching Postgres.app"
#  open "/Applications/Postgres.app"
#fi
#
source '/usr/local/share/chruby/chruby.sh'
source '/usr/local/share/chruby/auto.sh'

chruby 2.3

#if [ "$PATH_MODIFIED" != "true" ]; then
#  export PATH_MODIFIED="true"
  export PATH="/usr/local/heroku/bin:$PATH"
  export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
  export PATH="~/bin:$PATH"
  export PATH="/usr/local/bin:$PATH"
#fi

source "`find /usr/local/Cellar/git -type f -name 'git-prompt.sh'| tail -1`"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PROMPT_COMMAND='__git_ps1 "\n  \[\e[0;31m\]$(__ruby_version)\[\e[0m\]" " $(__current_commit_sha)$(__print_parent_commit_info)\n\u@\h:\w ∴ "'

__print_parent_commit_info() {
  if [ "$PWD" = "/Users/dbender/Code/instructure/canvas" ]
  then
    echo '\n  HEAD~1 $(__parent_commit_sha) $(__parent_commit_date)'
  fi
}

__parent_commit_sha() {
  sha=$(git show -s --format="%C(yellow)%h%Creset" HEAD~1)
  echo "${sha}"
}

__current_commit_sha() {
  sha=$(git show -s --format="%C(yellow)%h%Creset" HEAD)
  echo "${sha}"
}

__parent_commit_date() {
  date=$(__parent_commit_sha | git show -s --format="%C(green)%cd%Creset" --date=local )
  echo "${date:-none}"
}
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

#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
#  #fortune -n 160 | cowsay
#fi

# Auto create tmux session, or attach to detached sessions.
# Attached sessions are left alone on purpose - detach/attach to them manually as needed.
if [[ $TMUX == "" ]]; then
    if [[ $(tmux ls | grep -v "(attached)" | wc -l) -ne 0 ]]; then
        #echo "There is an unattached session I'd be trying to attach to"
        tmux attach-session -t $(tmux ls | grep -v "(attached)" | head -n 1 | awk '{print $1}')
    else
        #echo "No sessions available.  Would be creating new session."
        tmux
    fi
fi

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export CDPATH=$CDPATH:~/Code/foss

alias convert_flac_to_alac='for file in *.flac; do ffmpeg -i "$file" -acodec alac "`basename "$file" .flac`.m4a"; done;'

alias start_mongodb='launchctl load /usr/local/opt/mongodb/homebrew.mxcl.mongodb.plist'
alias stop_mongodb='launchctl unload /usr/local/opt/mongodb/homebrew.mxcl.mongodb.plist'
alias disable_terminal_badge='defaults write com.apple.Terminal no-bouncing -bool TRUE'
alias enable_terminal_badge='defaults write com.apple.Terminal no-bouncing -bool FALSE'
alias git_submodule_update_all='git submodule foreach git pull origin master'
alias redis_run='redis-server /usr/local/etc/redis.conf'
alias reset_spotlight_position='defaults delete com.apple.Spotlight userHasMovedWindow'
alias rspec_bisect_speed_grader="bundle exec rspec --bisect --seed 35576 spec/models/speed_grader_spec.rb spec/models/assignment_spec.rb spec/controllers/gradebooks_controller_spec.rb && echo 'RSpec Bisect Done!' | terminal-notifier -sound default"

## fasd
#eval "$(fasd --init auto)"

# NVM for Node
export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh
#source /usr/local/opt/nvm/nvm.sh
alias nvm_load="time source /usr/local/opt/nvm/nvm.sh"
export PATH=/Users/dbender/.nvm/versions/node/v0.12.7/bin:$PATH

source ~/.sailfish
cd ~/Code/instructure/canvas/
#source /usr/local/etc/bash_completion.d/password-store
export CANVAS_DISABLE_CACHE_LOG=true
export SKIP_JS_REV=1
export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_CERT_PATH=/Users/dbender/.docker/machine/machines/dinghy
export DOCKER_TLS_VERIFY=1
export DOCKER_MACHINE_NAME=dinghy
