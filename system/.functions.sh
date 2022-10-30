#!/usr/bin/env bash
# kimchi dotfiles

# Calculator

calc() {
  echo "$*" | bc -l;
}

# Weather

meteo() {
  LOCALE=$(echo "${LANG:-en}" | cut -c1-2)
  if [ $# -eq 0 ]; then
    LOCATION=$(curl -s ipinfo.io/loc)
  else
    LOCATION=$1
  fi
  curl -s "$LOCALE.wttr.in/$LOCATION"
}

function sso-login() {
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

function docker-login(){
  docker login --username iamkimchi
}

# nate specific
function nate-init(){
  # shellcheck source=/dev/null
  source "${HOME}/.naterc"
  aws codeartifact login --tool npm --domain "${NATE_NPM_DOMAIN}" --repository js --namespace "${NATE_NPM_NAMESPACE}"
  aws ecr get-login-password --profile default | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com"
}

function aws-get-current-role(){
  aws sts get-caller-identity
}

