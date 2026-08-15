# hey, dotfiles

> My macOS setup. Fast, minimal, mine.

```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
git clone <private-remote> ~/git/private
cd ~/dotfiles && sh install.sh
```

`install.sh` exits immediately if `~/git/private/dotfiles` is missing. Override with `PRIVATE_DOTFILES_DIR=/path/to/private/dotfiles sh install.sh` if needed.

## what's inside

| component | what it does |
|-----------|--------------|
| **zsh** | shell config + aliases/functions |
| **tmux** | minimal persistent terminal bootstrap |
| **config/** | app configs (gh, ghostty, oh-my-posh, zed) |
| **codiff** | local diff viewer app + config |
| **private bin/** | helper scripts linked into `~/.local/bin` |
| **mail automation** | private Apple Mail automation bootstrap hook |
| **micromamba** | python environments (conda-compatible) |
| **Vite+** | Node.js, package managers, and global JavaScript tools |
| **Brewfile** | homebrew packages |
| **apps/** | karabiner, raycast, iterm, sublime, zotero |

## quick links

- Aliases: `~/.zsh/alias.zsh`
- Functions: `~/.zsh/functions.zsh`
- Codex usage: `ccusage daily|monthly|session`
- PDF extraction: `pdf-to-markdown input.pdf [output.md]`
- tmux: `~/.tmux.conf`
- Profile: `~/.zprofile`
- Git: `~/.gitconfig`
- GH CLI: `~/.config/gh/config.yml`
- Ghostty: `~/.config/ghostty/config`
- Codiff: `~/.codiff/codiff.jsonc`
- Oh My Posh: `~/.config/oh-my-posh/config.json`
- Zed: `~/.config/zed/settings.json`
- Sublime: `~/Library/Application Support/Sublime Text/Packages/User`

## notes

- Python via `micromamba` (run `conda` alias works)
- Node.js and JavaScript package managers via Vite+; use `vp install`, `vp run`, and `vp pm`
- Global JavaScript tools installed by setup: `ccusage`, `pdf-to-markdown`, `qmd`, `mcporter`, and `tsc`
- Sensitive local config lives in `~/git/private/dotfiles/`
- `install.sh` links core configs, including `config/codiff/codiff.jsonc` -> `~/.codiff/codiff.jsonc`
- `install.sh` will link private overlays when present:
- `zsh/env.zsh` -> `~/.config/secrets/env.zsh`
- `zsh/private.zsh` -> `~/.config/secrets/private.zsh`
- `git/config.private` -> `~/.config/git/config.private`
- `git/allowed_signers` -> `~/.config/git/allowed_signers`
- `config/gh/hosts.yml` -> `~/.config/gh/hosts.yml`
- `config/codex/hooks.json` -> `~/.codex/hooks.json`
- `ssh/config` -> `~/.ssh/config`
- `apps/sublime/User/MySFTP/servers/server.json` -> `~/Library/Application Support/Sublime Text/Packages/User/MySFTP/servers/server.json`
- `agents/` -> `~/.agents`
- `agents/AGENTS.md` -> `~/.codex/AGENTS.md`
- `agents/skills/` -> `~/.codex/skills`
- `agents/prompts/` -> `~/.codex/prompts`
- `bin/committer` -> `~/.local/bin/committer`
- `bin/setup-mail-automation` -> `~/.local/bin/setup-mail-automation`
- `bin/setup-codex-plugins` -> `~/.local/bin/setup-codex-plugins`
- Open Sublime once after setup, then run `Package Control: Satisfy Dependencies` if any packages are missing
- Codiff installs from `nkzw-tech/tap/codiff`; setup also clones `https://github.com/nkzw-tech/codiff.git` to `~/git/oss/codiff` for the Codex skill target
- Private Codex plugins are installed during setup when `codex` is available.
- Mail automation lives in private dotfiles. After Mail accounts are configured, run `setup-mail-automation`.

## tmux

- `install.sh` links `.tmux.conf` to `~/.tmux.conf`
- `tm` attaches to or creates a tmux session for the current git root (or current directory outside git)
- Start simple:
  - `tm`
  - `Ctrl-b d` to detach
  - `Ctrl-b |` or `Ctrl-b -` to split in the current directory
  - `Ctrl-b r` to reload config
- Keep using Ghostty tabs for quick one-offs; use tmux for persistent shells, remote work, servers, logs, and long-running jobs
