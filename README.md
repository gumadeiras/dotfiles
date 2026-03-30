# hey, dotfiles

> My macOS setup. Fast, minimal, mine.

```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
git clone <private-remote> ~/git/private
cd ~/dotfiles && sh install.sh
```

## what's inside

| component | what it does |
|-----------|--------------|
| **zsh** | shell config + aliases/functions |
| **config/** | app configs (gh, ghostty, oh-my-posh, zed) |
| **micromamba** | python environments (conda-compatible) |
| **Brewfile** | homebrew packages |
| **apps/** | karabiner, raycast, iterm, sublime, zotero |

## quick links

- Aliases: `~/.zsh/alias.zsh`
- Functions: `~/.zsh/functions.zsh`
- Profile: `~/.zprofile`
- Git: `~/.gitconfig`
- GH CLI: `~/.config/gh/config.yml`
- Ghostty: `~/.config/ghostty/config`
- Oh My Posh: `~/.config/oh-my-posh/config.json`
- Zed: `~/.config/zed/settings.json`
- Sublime: `~/Library/Application Support/Sublime Text/Packages/User`

## notes

- Python via `micromamba` (run `conda` alias works)
- Sensitive local config lives in `~/git/private/dotfiles/`
- `install.sh` will link private overlays when present:
- `zsh/env.zsh` -> `~/.config/secrets/env.zsh`
- `zsh/private.zsh` -> `~/.config/secrets/private.zsh`
- `git/config.private` -> `~/.config/git/config.private`
- `git/allowed_signers` -> `~/.config/git/allowed_signers`
- `config/gh/hosts.yml` -> `~/.config/gh/hosts.yml`
- `ssh/config` -> `~/.ssh/config`
- Open Sublime once after setup, then run `Package Control: Satisfy Dependencies` if any packages are missing
