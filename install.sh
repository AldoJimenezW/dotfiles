#!/bin/bash

PAQUETES=(
  hyprland
  hyprpaper
  hyprlock
  waybar
  wofi
  dunst
  feh
  alacritty
  btop
  dconf
  emacs
  pavucontrol
  vivaldi
  zsh
)

sudo zypper install -y ${PAQUETES[@]}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

doom sync

mkdir -p ~/.config
cp -r dotfiles/* ~/.config/

