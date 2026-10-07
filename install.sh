#!/bin/bash

set -e

echo "Refreshing openSUSE repositories..."
sudo zypper refresh

PACKAGES=(
  git
  gh
  stow
  curl
  helix
  zsh
  kitty
  cava
  fastfetch
  elementary-xfce-icon-theme
)

echo "Installing packages..."
sudo zypper install -y "${PACKAGES[@]}"

# Install oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  # RUNZSH=no stops it from dropping you into new zsh shell mid-script
  # CHSH=no stops it from asking to change default shell immediately
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # Deletes the default .zshrc created by the installer so Stow can symlink
  if [ -f "$HOME/.zshrc" ]; then
    rm "$HOME/.zshrc"
  fi
else
  echo "Oh My Zsh is already installed. Skipping..."
fi

# Stow dotfiles
DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

FOLDERS=(
  cava
  fastfetch
  fonts
  helix
  kitty
  wallpapers
  xfce4
  zshrc
)

echo "Stowing configurations..."
for folder in "${FOLDERS[@]}"; do
  echo "Stowing $folder"
  stow -v -R -t "$HOME" "$folder"
done

# Change zsh to default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing your default shell to Zsh..."
  chsh -s "$(which zsh)"
fi

echo "openSUSE and Oh My Zsh environment setup complete!"
