#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_PATH="$HOME/.config"

[[ ! -d "$CONFIG_PATH" ]] && mkdir -p "$CONFIG_PATH"
[[ ! -d "$HOME"/.local/share/fonts ]] && mkdir -p "$HOME"/.local/share/fonts

function dotInstall(){
	cp -r "$SCRIPT_DIR"/dotfiles/{dunst,i3,kitty,polybar,rofi} "$CONFIG_PATH"
	cp -r "$SCRIPT_DIR"/dotfiles/fonts/*.ttf "$HOME"/.local/share/fonts
	fc-cache -fv
	cp -r "$SCRIPT_DIR"/dotfiles/wallpaper.png "$HOME"/.wallpaper.png
}

function main(){
	while true; do
		clear
		printf "\033[0;93mWARNING:\033[0m This action will erase all previous settings involving dotfiles. Do you wish to continue?\n"
		read -p "[Y/n] " userConfirmation
		[[ -z "$userConfirmation" ]] && userConfirmation="y"
		if [[ "$userConfirmation" == "Y" || "$userConfirmation" == "y" ]]; then
			rm -rf "$CONFIG_PATH"/{dunst,i3,kitty,polybar,rofi}
			dotInstall
			exit 0
		elif [[ "$userConfirmation" == "N" || "$userConfirmation" == "n" ]]; then
			exit 1
		else
			printf "\033[0;91m==> ERROR:\033[0m Invalid option.\n"
			sleep 1.5
		fi
	done
}

main
