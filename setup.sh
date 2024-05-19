#!/bin/bash

usage() {
	printf "Usage: $0 [-f] \n\nOptions:\n    -f: force link; also creates dirs\n";
	exit 1;
}

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# reset in case getopts has been used previously in shell
OPTIND=1
while getopts "f" opt; do
	case "$opt" in
		f)
			f='f'
			echo Creating required directories...
			mkdir -p ~/.zsh ~/.config/nvim ~/.local/bin
			;;
		*)
			usage
	esac
done

# zsh stuff
echo Linking zsh stuff...
ln -sv$f $SCRIPT_DIR/zsh/zshrc ~/.zshrc
ln -sv$f $SCRIPT_DIR/zsh/* ~/.zsh

# nvim stuff
echo Linking nvim stuff...
ln -sv$f $SCRIPT_DIR/nvim/* ~/.config/nvim

# i3 stuff
echo Linking i3 stuff...
ln -sv$f $SCRIPT_DIR/i3/config ~/.i3/config

# tmux stuff
echo Linking tmux stuff...
ln -sv$f $SCRIPT_DIR/tmux/config ~/.tmux.conf
