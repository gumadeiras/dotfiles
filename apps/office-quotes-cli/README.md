# 🎬 office-quotes

Offline CLI for The Office quotes. Based on the [Raycast Office Quotes](https://github.com/raycast/extensions/tree/main/extensions/office-quotes) extension.

## Install

```sh
# Add to your PATH, or create an alias
alias office-quotes="$HOME/dotfiles/apps/office-quotes-cli/office-quotes"

# Or symlink to ~/bin
mkdir -p ~/bin
ln -sf ~/dotfiles/apps/office-quotes-cli/office-quotes ~/bin/office-quotes
```

## Usage

```sh
office-quotes              # Random quote
office-quotes random       # Same as above
office-quotes shuffle      # Another random quote
office-quotes list         # All quotes
office-quotes list dwight  # Dwight quotes only
office-quotes characters   # List all characters
office-quotes search "bears. beets."  # Search quotes
office-quotes copy         # Copy to clipboard
office-quotes -q           # Quote only (no character)
```

## Requirements

- `jq` - JSON processor (`brew install jq`)
- `zsh`

## Data

Quotes stored in `data/quotes.json` (sourced from Raycast extension, 1300+ quotes).
