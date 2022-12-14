#!/usr/bin/env bash
# kimchi dotfiles

# shortcuts
alias reload="source ~/.bash_profile"
alias _="sudo"

# terraform
alias tf="terraform"
alias terraform_v1.0.9="/usr/local/bin/terraform_v1.0.9"

alias k="kubectl"

# git
alias git-show-config="git config --global --list --show-origin"

alias git-log="git log --color --graph --date=format:'%Y-%m-%d-%H:%M' --pretty=format:'%Cred%h%Creset - %Cgreen%ad%C(yellow)%d%Creset %s %C(bold blue)%an %Creset'"

# ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# docker
alias docker-prune='docker system prune -a'
alias docker-rmi-all='docker rmi -f $(docker images -aq)'
alias docker-rm-all='docker rm -vf $(docker ps -aq)'

# show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"
# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"
alias check-sum-256="shasum -a 256"

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec ${SHELL} -l'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'


# Miscellaneous
alias hosts='sudo $EDITOR /etc/hosts'
alias quit="exit"
alias week="date +%V"
alias speedtest="speedtest-cli"

if [[ "${OSTYPE}" =~ ^darwin ]]; then
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
  alias g=/Users/kimchi/go/bin/g
  alias lsusb="ioreg -p IOUSB"
  alias ghci="stack ghci"
  alias hrun="stack exec runghc"
  alias ghc="stack ghc"
  alias ibrew="arch -x86_64 /opt/homebrew/bin/brew"
else
  export PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin
fi
