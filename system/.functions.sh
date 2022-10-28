#!/usr/bin/env bash
# kimchi dotfiles
# vim: filetype=sh

ps0() {
  unset PROMPT_COMMAND
  PS1='$ '
}

ps1() {
  source "$DOTFILES_DIR"/.prompt
}

# Get named var (usage: get "VAR_NAME")

get() {
  echo "${!1}"
}

# Add to path

prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}

# Calculator

calc() {
  echo "$*" | bc -l;
}

# Weather

meteo() {
  local LOCALE=$(echo ${LANG:-en} | cut -c1-2)
  if [ $# -eq 0 ]; then
    local LOCATION=$(curl -s ipinfo.io/loc)
  else
    local LOCATION=$1
  fi
  curl -s "$LOCALE.wttr.in/$LOCATION"
}

function ssologin() {
  if [ -n "$1" ]
  then
    echo "Logging in with role $1"
    aws sso login --profile "$1"
    python3 -m yawsso --profile "$1"
    export AWS_PROFILE="$1"
  else
    echo "Logging in with role default"
    aws sso login --profile "default"
    python3 -m yawsso --default
    export AWS_PROFILE="default"
  fi
}

# nate specific
nateInit(){
  aws codeartifact login --tool npm --domain nate-js --repository js --namespace @nate
  aws ecr get-login-password --profile default | docker login --username AWS --password-stdin 847574585735.dkr.ecr.eu-west-1.amazonaws.com
}

aws-get-current-role(){
  aws sts get-caller-identity
}
