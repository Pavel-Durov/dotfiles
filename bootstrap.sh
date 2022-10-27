#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

TARGET="${HOME}/.dotfiles"
function _init() {
  rm -fr ${TARGET}
  mkdir ${TARGET}
  cp -r ./system ${TARGET}
  cp -r ./config ${TARGET}
  rm ${HOME}/.bash_profile
  rm ${HOME}/.gitconfig
  rm ${HOME}/.vimrc
  ln -sv "${TARGET}/config/.bash_profile" ~
  ln -sv "${TARGET}/config/.gitconfig" ~
  ln -sv "${TARGET}/config/.vimrc" ~
	source ${HOME}/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	_init;
else
	read -p "This action will overwrite existing files in your ${HOME} directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		_init;
	fi;
fi;
unset _init;
