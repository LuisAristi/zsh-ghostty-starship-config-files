# PowerShell-like terminal setup on Ubuntu 24.04

These are configuration files that allow you to quickly set up a terminal workflow inspired by PowerShell using Zsh, Ghostty, and Starship.

The current setup is designed to feel familiar to PowerShell users while keeping the flexibility and power of a modern Unix shell.

The `export-files.sh` script copies the local configuration files into the standard directories where these tools expect them to live. This helps simplify the workflow and makes it easier to maintain the setup across machines.

---

## Overview

This repository includes:

- `zshrc` — interactive shell behavior, history, key bindings, and completion
- `config.ghostty` — terminal emulator settings and keyboard shortcuts
- `starship.toml` — prompt theming and system status display

Together, these files create a streamlined, developer-friendly terminal environment.

---

## Zsh configuration

The shell config in `zshrc` is designed to behave more like a PowerShell-style interactive shell while keeping the productivity advantages of Zsh.

### Emacs-style editing and Bash-like word movement

- `bindkey -e` enables Emacs-style key bindings.
- `autoload -U select-word-style` and `select-word-style bash` make word navigation feel closer to Bash and PowerShell conventions.
- Word movement is based on alphanumeric sequences rather than shell-specific token rules.

### History and command recall

The shell stores a persistent history using the following settings:

- `HISTFILE="$HOME/.zsh_history"`
- `HISTSIZE=10000`
- `SAVEHIST=10000`

Enabled options include:

- `HIST_IGNORE_DUPS` — ignores repeated commands
- `HIST_IGNORE_SPACE` — hides commands that begin with a space
- `SHARE_HISTORY` — shares history across shell sessions

### Custom word navigation

The config defines custom widgets for moving and selecting words:

- `power-left` and `power-right` move the cursor left or right by one word
- `power-select-left` and `power-select-right` place a mark and extend selection by word
- `power-backspace` removes the previous word or kills the current selection
- `power-delete` removes the next word or kills the current selection

This gives the terminal a more editor-like feel when editing commands.

### Common key bindings

These shortcuts are added for familiar command-line editing:

- `Ctrl + A` → beginning of line
- `Ctrl + E` → end of line
- `Ctrl + W` → delete the previous word
- `Ctrl + U` → clear from the cursor to the start of the line
- `Ctrl + K` → delete from the cursor to the end of the line
- `Ctrl + Y` → yank the last killed text

### History search

The config enables search through command history using the up/down arrow keys:

- `up-line-or-beginning-search`
- `down-line-or-beginning-search`

This makes it easier to find previous commands while typing a partial match.

### Clipboard support for selections

The shell includes a custom function named `copy-region-to-clipboard` that:

- checks whether a region is active
- copies the selected text
- sends it to Wayland clipboard using `wl-copy`
- deactivates the selection

This is useful for working in a GUI environment with terminal selection and clipboard integration.

### Completion system

Zsh completion is enabled with `compinit`, and the config customizes completion behavior:

- case-insensitive matching via `matcher-list`
- menu selection enabled for completions
- `Shift + Tab` mapped to reverse menu completion

This improves shell completion usability.

### Starship initialization

At the end of the file, the shell initializes Starship with:

```zsh
eval "$(starship init zsh)"
```

This loads the custom prompt configured in `starship.toml`.

---

## Ghostty configuration

The Ghostty config in `config.ghostty` customizes terminal keyboard behavior and appearance.

### Terminal appearance

The configuration uses:

- `font-family = JetBrainsMono NF Medium`
- `font-size = 14`
- `cursor-style = block`

This gives the terminal a crisp, modern developer look.

### Word navigation shortcuts

The terminal sends custom escape sequences for word-based movement:

- `Ctrl + Left` → move one word left
- `Ctrl + Right` → move one word right

These are mapped to CSI escape sequences:

- `csi:1;5D`
- `csi:1;5C`

### Word selection shortcuts

The config also supports selecting text by word:

- `Ctrl + Shift + Left`
- `Ctrl + Shift + Right`

This integrates with Zsh selection behavior to make command editing feel closer to GUI editors.

### Delete-word shortcuts

The following keyboard mappings are defined:

- `Ctrl + Backspace` → delete the previous word
- `Ctrl + Delete` → delete the next word

These mappings send custom sequences:

- `csi:99~`
- `csi:98~`

### Clipboard actions

Clipboard shortcuts are configured to simplify copy and paste:

- `Ctrl + V` → paste from clipboard
- `Ctrl + Shift + C` → copy selection to clipboard

This helps make terminal-based editing more natural and less dependent on mouse operations.

---

## Starship configuration

The `starship.toml` file defines a rich, colorful prompt for the shell. It is highly customized and shows a large amount of system and project information in a readable layout.

### Layout

The prompt is designed as a two-line display:

- first line: current system context, environment, and active project info
- second line: time, status, and final prompt character

This gives a dense but informative view of the shell state at a glance.

### Palette

A custom palette named `high_contrast` defines a vivid theme with colors such as:

- rosewater, pink, mauve, red, yellow, green, teal, blue, lavender
- dark base and near-white text colors for contrast

This creates a striking terminal aesthetic with high readability.

### Identity and privilege information

The prompt always shows identity-oriented data:

- username
- hostname
- shell level (`shlvl`)
- privilege indicator (`sudo`)
- local IP when using SSH

This makes it easier to understand the current shell context.

### Directory module

The directory section is configured to show the full current path, with features such as:

- visible `home_symbol`
- read-only indicator
- full path display rather than aggressive truncation

This helps keep location awareness high while working in nested project folders.

### Git integration

Git support is extremely detailed and includes:

- current branch and remote branch
- commit hash and tag display
- git state and progress indicators
- repository metrics like added/deleted lines
- status counts for modified, staged, deleted, renamed, and untracked files
- ahead/behind indicators

This makes the prompt highly useful for developers working inside large repositories.

### Runtime and language support

Starship is configured to show versions for many development tools and runtimes, including:

- Node.js
- Python
- Rust
- Go
- PHP
- Java
- Kotlin
- Haskell
- Scala
- Elixir
- Elm
- Erlang
- Lua
- Ruby
- Swift
- Zig
- Dart
- .NET
- Deno
- Bun
- Julia
- C and C++
- CMake
- Meson
- Conda
- Pixi

This makes the prompt valuable in multi-language development environments.

### Cloud and container awareness

The prompt also includes modules for:

- Docker context
- Kubernetes context and namespace
- Terraform workspace
- AWS profile and region
- GCP account and region
- Azure subscription
- OpenStack environment
- `direnv` status

This helps quickly confirm the active environment before running commands.

### Resource and system indicators

The prompt includes informational modules for:

- memory usage
- battery level
- active jobs
- command duration
- current time
- process status

These details provide operational context without requiring separate commands.

### Prompt character

The final prompt character is customized to indicate success or failure:

- green arrow for success
- red arrow for errors
- mauve arrow for Vim command mode

This gives visual feedback at a glance.

---

## Goal of this setup

The overall configuration aims to provide a terminal environment that combines the familiarity of PowerShell with the flexibility of modern Unix tools.

This setup is useful for:

- comfortable command editing
- quick navigation in long commands
- better shell context visibility
- multi-language development workflows
- a visually rich terminal with high productivity

---

## Notes

This repository is intended as a lightweight terminal customization setup for Ubuntu 24.04. It is designed to be easy to edit and export to the system directories where Zsh, Ghostty, and Starship expect their config files to live.
