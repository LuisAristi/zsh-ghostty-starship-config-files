#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating package list"
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  curl \
  p7zip-full \
  p7zip-rar \
  fontconfig \
  wget \
  ca-certificates \
  software-properties-common

echo "==> Installing JetBrainsMono Nerd Font"
mkdir -p "$HOME/.local/share/fonts"
cp ./font/JetBrainsMono.7z /tmp
cd /tmp
rm -rf JetBrainsMonoNerd
7z x JetBrainsMono.7z -oJetBrainsMonoNerd >/dev/null
mv JetBrainsMonoNerd/*.ttf "$HOME/.local/share/fonts/"
fc-cache -fv

echo "==> Installing zsh from apt"
sudo apt-get install -y --no-install-recommends zsh

echo "==> Installing ghostty from github"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

echo "==> Installing starship"
curl -sS https://starship.rs/install.sh | sh

echo "==> Verifying installed tools"
command -v zsh
command -v ghostty
command -v starship
fc-match "JetBrainsMono Nerd Font" | head -n 1

echo "==> Installation complete"