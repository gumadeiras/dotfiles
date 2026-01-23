# office-quotes

Offline + Online CLI for The Office quotes. Supports SVG cards, episode metadata, and character avatars.

## Install

```sh
ln -sf ~/dotfiles/apps/office-quotes-cli/office-quotes ~/bin/office-quotes
```

## Usage

### Offline Mode (326 local quotes)

```sh
office-quotes                     # Random quote
office-quotes random              # Same
office-quotes -q                  # Quote only (no character)
office-quotes list dwight         # Dwight quotes only
office-quotes list michael        # Michael quotes only
office-quotes characters          # List all characters
office-quotes count               # Show quote count
office-quotes search "bears"      # Search quotes
```

### Online Mode (API + SVG cards + Episode data)

```sh
# Random quote as SVG card
office-quotes api random

# Get SVG image URL
office-quotes api random --image
https://officeapi.akashrajpurohit.com/quote/random?responseType=svg&mode=dark&width=400&height=200

# Light theme SVG
office-quotes api random --light

# Custom size SVG
office-quotes api random --width 600 --height 300

# JSON response with metadata
office-quotes api json

# Episode metadata
office-quotes --episode 3/10
# {"season":3,"episode":10,"title":"A Benihana Christmas",...}

# Season overview
office-quotes --season 1
```

## Features

| Feature | Offline | Online |
|---------|---------|--------|
| Random quotes | 326 | Unlimited |
| Search | Local | - |
| SVG cards | - | Yes |
| Character avatars | - | Yes |
| Episode metadata | - | Yes |
| IMDB ratings | - | Yes |

## Data Sources

- **Offline:** [Raycast Office Quotes](https://github.com/raycast/extensions/tree/main/extensions/office-quotes) extension
- **Online:** [akashrajpurohit/the-office-api](https://github.com/AkashRajpurohit/the-office-quotes-api)

## Requirements

- `jq` - JSON processor
- `curl` - For API calls
- `bash` or `zsh`
