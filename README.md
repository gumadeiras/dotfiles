# hey, dotfiles

> My macOS setup. Fast, minimal, mine.

```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
cd ~/dotfiles && sh install.sh
```

## what's inside

| component | what it does |
|-----------|--------------|
| **zsh** | shell config + aliases/functions |
| **micromamba** | python environments (conda-compatible) |
| **Brewfile** | homebrew packages |
| **apps/** | karabiner, raycast, iterm, zotero |

## quick links

- Aliases: `~/.zsh/alias.zsh`
- Functions: `~/.zsh/functions.zsh`
- Git: `~/.gitconfig`

## notes

- Python via `micromamba` (run `conda` alias works)
- SSH credentials live in `~/.ssh/config`, never here
- Alfred and BetterTouchTool removed
