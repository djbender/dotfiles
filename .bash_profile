#!/usr/bin/env bash
shopt -s globstar
# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# bash completion
EXECIGNORE=$(command -v dc)
export EXECIGNORE
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"

# FZF
# shellcheck source=/Users/dbender/.fzf.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --ignore-file ~/.config/fdignore --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# shellcheck source=/usr/local/Cellar/git/2.27.0/etc/bash_completion.d/git-prompt.sh
source "$(find /usr/local/Cellar/git -type f -name 'git-prompt.sh'| tail -1)"
# shellcheck source=/usr/local/Cellar/git/2.27.0/etc/bash_completion.d/git-completion.bash
source "$(find /usr/local/Cellar/git -type f -name 'git-completion.bash'| tail -1)"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export PROMPT_COMMAND='__git_ps1 "\n  \[\e[0;31m\]$(__ruby_version)\[\e[0m\]" " $(__current_commit_sha)$(__print_parent_commit_info)\n\u@\h:\w ∴  "'
# export PROMPT_COMMAND='__git_ps1 "\n  COMPOSE_FILE=$COMPOSE_FILE \n  COMPOSE_PROJECT_NAME=$COMPOSE_PROJECT_NAME \n  PATCHSET_TAG=$PATCHSET_TAG\n  NAME=$NAME\n  \[\e[0;31m\]$(__ruby_version)\[\e[0m\]" " $(__current_commit_sha)$(__print_parent_commit_info)\n\u@\h:\w ∴  "'


__print_parent_commit_info() {
  true
	if [ "$PWD" = "/Users/dbender/exempt/Code/Instructure/canvas" ]
	then
		printf "\n  HEAD~1 %s %s", "$(__parent_commit_sha)", "$(__parent_commit_date)"
	fi
}

__parent_commit_sha() {
  if [ -d "$PWD/.git" ] # && [ ! -f "$HOME/.ignore-bash-git" ]# && [ "$(git show -s HEAD)" != 0 ]
  then
    sha=$(git show -s --format="%C(yellow)%h%Creset" HEAD~1)
    echo "${sha}"
  fi
}

__current_commit_sha() {
  if [ -d "$PWD/.git" ] # && [ ! -f "$HOME/.ignore-bash-git" ] # && [ "$(git show -s HEAD)" = 0 ]
  then
    sha=$(git show -s --format="%C(yellow)%h%Creset" HEAD)
    echo "${sha}"
  fi
}

__parent_commit_date() {
  if [ -d "$PWD/.git" ] # && [ ! -f "$HOME/.ignore-bash-git" ] # && [ "$(git show -s HEAD)" != 0 ]
  then
    date=$(git show -s --format="%C(green)%cd%Creset" --date=local )
    echo "${date:-none}"
  fi
}

__ruby_version() {
	[ "$RUBY_VERSION" ] || sys='system: '
	ver=$(ruby -v 2>/dev/null | awk '{print $1"-"$2}')
	echo "$sys${ver:-none}"
}

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.nvm/versions/node/v12.16.1/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/exempt/Code/FOSS/go"
export PATH="$GOPATH/bin:$PATH"

export NVM_DIR="$HOME/.nvm"

# docker-compose
alias dc="docker-compose"
alias dcr="dc run --rm"
alias dcrw="dcr web"

# git
alias gca="git commit --amend"
alias gcane="git commit --amend --no-edit"
alias git-prune-branches='git branch --merged | grep -v "master" | grep -v "main" | xargs git branch -d'

alias docker-stop-all="docker stop \$(docker ps -a -q)"

docker-compose() {
  if [ "$1" == "down" ] && [ "$2" != "--help" ] && [ "$2" != "-h" ] ; then
    echo "Running \`docker-compose stop\` first"
    /usr/bin/env docker-compose stop
  fi
  /usr/bin/env docker-compose "$@"
}

alias nvm_load=". \$NVM_DIR/nvm.sh && . \$NVM_DIR/bash_completion"

alias mount_personal="hdiutil attach ~/Documents/Personal.sparsebundle -stdinpass"
alias mutant_luhn="bundle exec mutant --include lib --require luhn --use rspec Numeric#luhn?"
alias mutant_cmd="echo 'bundle exec mutant --include lib --require luhn --use rspec Numeric#luhn?'"

alias redis_run="redis-server /usr/local/etc/redis.conf"

alias tmlogs="log show --last 12h --style syslog  --predicate 'senderImagePath contains[cd] \"TimeMachine\"' --info"
alias l="exa"
alias ll="exa -l"

# paths
alias buc="cd ~/exempt/Code/Bridge/bridge-ui-components/ && echo +cd ~/exempt/Code/Bridge/bridge-ui-components/"

export COMPOSE_HTTP_TIMEOUT=300

export VISUAL=vim
export EDITOR="$VISUAL"

export SPEC_TIME_LIMIT_TARGET=60

# alias validateJenkinsfile=curl -u dbender:$JENKINS_API -X POST -F "jenkinsfile=<Jenkinsfile" $JENKINS_URL/pipeline-model-converter/validate

export SUPPRESS_RUBY_WARNING=true

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export SPLUNK_PASSWORD=password

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

export ALPINE_MIRROR=http://mirrors.gigenet.com/alpinelinux

shopt -s histappend

export RUBYOPT="-W0"
export GREP_OPTIONS='--color=always'
alias tfenv='GREP_OPTIONS="--color=never" tfenv'
alias unload-bash-profile='env -i bash --norc --noprofile'

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

eval "$( command rapture shell-init )"

eval $(thefuck --alias)

cd ~/exempt/Code/Bridge/bridge-ui-components || return
