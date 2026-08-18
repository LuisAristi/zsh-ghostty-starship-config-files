#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating package list"
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  curl \
  unzip \
  fontconfig \
  wget \
  ca-certificates \
  software-properties-common

echo "==> Installing JetBrainsMono Nerd Font"
mkdir -p "$HOME/.local/share/fonts"
cp ./font/JetBrainsMono.zip /tmp
cd /tmp
rm -rf JetBrainsMonoNerd
unzip -o JetBrainsMono.zip -d JetBrainsMonoNerd >/dev/null
mv JetBrainsMonoNerd/*.ttf "$HOME/.local/share/fonts/"
fc-cache -fv

echo "==> Installing zsh from apt"
sudo apt-get install -y --no-install-recommends zsh

echo "==> Installing ghostty from apt"
if ! command -v ghostty >/dev/null 2>&1; then
  sudo add-apt-repository -y ppa:apricot/ghostty
  sudo apt-get update
fi
sudo apt-get install -y --no-install-recommends ghostty

echo "==> Installing starship"
curl -sS https://starship.rs/install.sh | sh

echo "==> Verifying installed tools"
command -v zsh
command -v ghostty
command -v starship
fc-match "JetBrainsMono Nerd Font" | head -n 1

./export-files.sh
echo "==> Installation complete"