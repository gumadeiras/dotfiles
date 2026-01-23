# hey, dotfiles
Modern macOS dotfiles configuration.

## Usage

```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install.sh
```

## What this does

- Install Homebrew + packages (see `Brewfile`)
- Install oh-my-zsh + configuration
- Set up zsh with powerlevel10k theme
- Link dotfiles (zshrc, aliases, functions)
- Set up git configuration

## Requirements

- macOS (tested on Ventura+)
- Homebrew installed
- zsh 5+

## Setup steps

1. **Install Homebrew** (if not installed):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Run install script**:
   ```sh
   cd ~/dotfiles
   sh install.sh
   ```

3. **Install fonts** (optional):
   ```sh
   brew install homebrew/cask-fonts/font-fira-code
   brew install homebrew/cask-fonts/font-jetbrains-mono
   ```

4. **Configure powerlevel10k**:
   ```sh
   p10k configure
   ```

## Customization

Edit these files for your setup:
- `~/.zsh/alias.zsh` - Your aliases
- `~/.zsh/functions.zsh` - Your functions
- `~/.gitconfig` - Git configuration
- `Brewfile` - Add/remove Homebrew packages

## Apps & Configs

Additional configs in `./apps`:
- `alfred/` - Alfred preferences
- `bettertouchtool/` - BTT preset
- `htop/` - htop configuration
- `iterm/` - iTerm2 preferences
- `karabiner/` - Karabiner-Elements config
- `raycast/` - Raycast extensions
- `zotero/` - Zotero settings

## Notes

- Uses `powerlevel10k` instead of deprecated `powerlevel9k`
- Uses `gh` instead of deprecated `hub`
- Python managed via **micromamba** (faster, lighter than conda)
  - Run: `micromamba create -n myenv python=3.11`
  - Activate: `micromamba activate myenv`
  - `conda` alias works for compatibility
- CTF/security tools removed (add back via Brewfile if needed)
- Fonts separated into cask (use `homebrew/cask-fonts` tap)

## Security

⚠️ **SSH credentials and API keys have been removed from this repo**
- SSH aliases moved to `~/.ssh/config`
- API keys in Alfred workflows redacted (add your own)
- Always use environment variables or keychain for secrets

## Troubleshooting

### Powerlevel10k not showing?
```sh
p10k configure
# or
git clone https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
```

### Homebrew cask issues?
```sh
brew install --cask <app>  # instead of brew cask install
```

### Python versions?
```sh
pyenv install 3.12.0
pyenv global 3.12.0
```
