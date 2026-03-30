#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRIVATE_DOTFILES_DIR="${PRIVATE_DOTFILES_DIR:-$HOME/git/private/dotfiles}"

if [[ ! -d "$PRIVATE_DOTFILES_DIR" ]]; then
  echo "[error] private dotfiles not found at $PRIVATE_DOTFILES_DIR"
  echo "[error] clone or set up your private repo first, then rerun install.sh"
  exit 1
fi

link_file() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  ln -s "$src" "$dest"
}

link_private_if_exists() {
  local src="$1"
  local dest="$2"
  if [[ -e "$src" ]]; then
    echo "[exec] linking private $(basename "$dest")"
    link_file "$src" "$dest"
  fi
}

echo "[exec] hi :)"
echo "[exec] installing xcode tools"
xcode-select --install || true

# Check for Homebrew
if ! command -v brew &> /dev/null; then
  echo "[exec] installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "[exec] installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "[exec] making zsh the default shell"
chsh -s /bin/zsh

# Install fonts (optional but recommended for powerlevel10k)
echo "[exec] installing fonts"
brew tap homebrew/cask-fonts || true
# brew install --cask font-fira-code || true
# brew install --cask font-jetbrains-mono || true

echo "[exec] linking dotfiles"
mkdir -p ~/.zsh
mkdir -p ~/.config/karabiner
mkdir -p ~/.config/gh
mkdir -p ~/.config/git
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/oh-my-posh
mkdir -p ~/.config/secrets
mkdir -p ~/.config/zed
mkdir -p ~/.codex
mkdir -p ~/.ssh

link_file "$DOTFILES_DIR/zsh/zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/alias.zsh" "$HOME/.zsh/alias.zsh"
link_file "$DOTFILES_DIR/zsh/functions.zsh" "$HOME/.zsh/functions.zsh"

link_file "$DOTFILES_DIR/apps/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
link_file "$DOTFILES_DIR/config/gh/config.yml" "$HOME/.config/gh/config.yml"
link_file "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/config/oh-my-posh/config.json" "$HOME/.config/oh-my-posh/config.json"
link_file "$DOTFILES_DIR/config/zed/settings.json" "$HOME/.config/zed/settings.json"

link_file "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/gitignore_global" "$HOME/.gitignore_global"

link_private_if_exists "$PRIVATE_DOTFILES_DIR/zsh/env.zsh" "$HOME/.config/secrets/env.zsh"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/zsh/private.zsh" "$HOME/.config/secrets/private.zsh"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/git/config.private" "$HOME/.config/git/config.private"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/git/allowed_signers" "$HOME/.config/git/allowed_signers"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/config/gh/hosts.yml" "$HOME/.config/gh/hosts.yml"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/apps/sublime/User/MySFTP/servers/server.json" "$HOME/Library/Application Support/Sublime Text/Packages/User/MySFTP/servers/server.json"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/agents" "$HOME/.agents"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/agents/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/agents/skills" "$HOME/.codex/skills"
link_private_if_exists "$PRIVATE_DOTFILES_DIR/agents/prompts" "$HOME/.codex/prompts"

sublime_user_dir="$HOME/Library/Application Support/Sublime Text/Packages/User"
sublime_dotfiles_dir="$DOTFILES_DIR/apps/sublime/User"
mkdir -p "$sublime_user_dir"
if [[ -d "$sublime_dotfiles_dir" ]]; then
  while IFS= read -r -d '' src_file; do
    rel="${src_file#"$sublime_dotfiles_dir"/}"
    case "$rel" in
      *.example.json) continue ;;
    esac
    mkdir -p "$sublime_user_dir/$(dirname "$rel")"
    ln -sf "$src_file" "$sublime_user_dir/$rel"
  done < <(find "$sublime_dotfiles_dir" -type f -print0)
fi

echo "[exec] running brew bundle"
brew bundle --file="$DOTFILES_DIR/Brewfile" || echo "[warn] brew bundle failed, continuing..."

# Install micromamba for Python environment management
echo "[exec] installing micromamba"
if ! command -v micromamba &> /dev/null; then
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /usr/local/bin bin/micromamba
  micromamba shell init -s zsh -p ~/micromamba
fi

echo "[exec] installing powerlevel10k theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "[exec] installing zsh plugins"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "[exec] setting up git lfs"
git lfs install || true

echo "[exec] cleaning up"
brew cleanup
brew doctor || true

echo "[exec] done!"
echo "[exec] Next steps:"
echo "  1. Configure powerlevel10k: p10k configure"
echo "  2. Review ~/.zsh/alias.zsh and edit as needed"
echo "  3. Restart your terminal or: exec zsh"
echo "  4. Open Sublime Text and run: Package Control: Satisfy Dependencies (if any packages are missing)"
