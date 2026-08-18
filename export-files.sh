#!/bin/sh

ZSHRC_LOCATION="$HOME/.zshrc"
STARSHIP_LOCATION="$HOME/.config/starship.toml"
GHOSTTY_LOCATION="$HOME/.config/ghostty/config.ghostty"

echo "[INFO] Copying configuration files to respective folders..."

mkdir -p "$HOME/.config/ghostty" || {
    echo "[ERROR] ~/.config/ghostty couldn't be created"
    exit 1
}

echo "[OK] Ghostty Directory ready"

if cp ./zshrc "$ZSHRC_LOCATION"; then
    echo "[OK] .zshrc → $ZSHRC_LOCATION"
else
    echo "[ERROR] .zshrc couldn't be copied"
    exit 1
fi

if cp ./starship.toml "$STARSHIP_LOCATION"; then
    echo "[OK] starship.toml → $STARSHIP_LOCATION"
else
    echo "[ERROR] starship.toml couldn't be copied"
    exit 1
fi

if cp ./config.ghostty "$GHOSTTY_LOCATION"; then
    echo "[OK] config.ghostty → $GHOSTTY_LOCATION"
else
    echo "[ERROR] config.ghostty couldn't be copied"
    exit 1
fi

if zsh -c 'source "$HOME/.zshrc"'; then
    echo "[OK] zshrc config file sourced successfully"
else
    echo "[ERROR] zshrc couldn't  be sourced"
    exit 1
fi

echo "[OK] Todo instalado correctamente."