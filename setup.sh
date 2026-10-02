#!/bin/bash

usage() {
	printf "Usage: $0 [-g] [-f]\n\nOptions:\n    -g: full setup with GUI configs (i3, dunst, clipboard, ...); default is headless\n    -f: force link (overwrite existing files)\n";
	exit 1;
}

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# reset in case getopts has been used previously in shell
OPTIND=1
gui=''
while getopts "gf" opt; do
	case "$opt" in
		g)
			gui=1
			;;
		f)
			f='f'
			;;
		*)
			usage
	esac
done

if [ -n "$gui" ]; then
	echo "Setting up full (GUI) configs..."
else
	echo "Setting up headless configs..."
fi

# Links a GUI-only file in full mode; removes a previously linked one in headless mode
link_gui() {
	if [ -n "$gui" ]; then
		ln -sv$f "$1" "$2"
	elif [ -L "$2" ]; then
		rm -v "$2"
	fi
}

# zsh stuff
echo Linking zsh stuff...
# zshrc finds its files via its own symlink; remove the ~/.zsh link older versions created
# (or ~/.zsh/zsh, if ~/.zsh was a real directory)
for l in ~/.zsh ~/.zsh/zsh; do
	[ -L "$l" ] && [ "$(readlink "$l")" = "$SCRIPT_DIR/zsh" ] && rm -v "$l"
done
ln -sv$f "$SCRIPT_DIR/zsh/zshrc" ~/.zshrc
link_gui "$SCRIPT_DIR/zsh/zsh_gui" ~/.zsh_gui

# nvim stuff
echo Linking nvim stuff...
mkdir -p ~/.config/nvim
ln -sv$f "$SCRIPT_DIR"/nvim/{init.lua,lazy-lock.json,lsp,lua} ~/.config/nvim

# tmux stuff
echo Linking tmux stuff...
ln -sv$f "$SCRIPT_DIR"/tmux/config ~/.tmux.conf
link_gui "$SCRIPT_DIR/tmux/config_gui" ~/.tmux.gui.conf

[ -n "$gui" ] || exit 0

# i3 stuff
echo Linking i3 stuff...
mkdir -p ~/.i3
ln -sv$f "$SCRIPT_DIR"/i3/config ~/.i3/config
mkdir -p ~/.config/i3status-rust
ln -sv$f "$SCRIPT_DIR"/i3/statusbar.toml ~/.config/i3status-rust/config.toml

# dunst stuff
echo Linking dunst notification stuff
mkdir -p ~/.config/dunst
ln -sv$f "$SCRIPT_DIR"/dunst/dunstrc ~/.config/dunst/dunstrc
