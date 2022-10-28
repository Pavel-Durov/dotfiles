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
