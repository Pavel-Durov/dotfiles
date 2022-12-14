#!/usr/bin/env bash
# kimchi dotfiles

export PATH="${HOME}/.dotfiles/bin:$PATH"

# go
export GOPATH="$HOME/go"; 
export GOROOT="$HOME/.go"; 
export PATH="$GOPATH/bin:$PATH"; 
export PATH="$GOROOT/bin:$PATH"; 
# g-install: do NOT edit, see https://github.com/stefanmaric/g

# nvm
NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export NVM_DIR
# path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/tools"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/${HOME}/.rbenv/shims:${PATH}"
export PATH="${PATH}/${JAVA_HOME}"

export RBENV_SHELL=bash
export PATH=${PATH}:${HOME}/.local/bin

export PATH=${PATH}:${HOME}/.yarn/bin
export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:/usr/local
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${PATH}:${HOME}/.poetry/bin"
export PATH="${PATH}:${HOME}/tools/swift-5.5-RELEASE-ubuntu20.04/usr/bin/"
export DOTFILES_HOME="${HOME}/.dotfiles"
# haskell
# shellcheck source=/dev/null
[ -f "/${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env

export PATH="${HOME}/anaconda3/bin/:${PATH}"

# history size
export HISTFILESIZE=1000000
export HISTSIZE=1000000

# maxos specific - keep the history
export SHELL_SESSION_HISTORY=0

[ -f /opt/homebrew/Cellar/boost/1.80.0/include/boost ] && export CPLUS_INCLUDE_PATH=/opt/homebrew/Cellar/boost/1.80.0/include/boost


function osx_exports(){
  export PATH="/usr/local/homebrew/opt/python@3.8/bin:$PATH"
  export PATH="/opt/homebrew/bin:${PATH}"
  export LDFLAG="-L/opt/homebrew/opt/libpq/lib"
  # disavles the annoying "The default interactive shell is now zsh." message
  export BASH_SILENCE_DEPRECATION_WARNING=1export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
  # [ -d '/opt/homebrew/Cellar/boost/1.80.0/include/boost' ] && export CPLUS_INCLUDE_PATH=/opt/homebrew/Cellar/boost/1.80.0/include/boost
  [ -f '/usr/libexec/java_home' ] && JAVA_HOME="$(/usr/libexec/java_home)" && export JAVA_HOME

  # conda
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("${HOME}"/opt/anaconda3/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "${HOME}/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          # shellcheck source=/dev/null
          . "${HOME}/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="${HOME}/opt/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}
if [[ "${OSTYPE}" =~ ^darwin ]]; then
  osx_exports
else
  export PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin
fi
