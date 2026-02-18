#!/usr/bin/env bash
set -e

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
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/oh-my-posh
mkdir -p ~/.config/zed

ln -sf ~/dotfiles/zsh/zprofile ~/.zprofile
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/alias.zsh ~/.zsh/alias.zsh
ln -sf ~/dotfiles/zsh/functions.zsh ~/.zsh/functions.zsh

ln -sf ~/dotfiles/apps/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -sf ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml
ln -sf ~/dotfiles/config/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/config/oh-my-posh/config.json ~/.config/oh-my-posh/config.json
ln -sf ~/dotfiles/config/zed/settings.json ~/.config/zed/settings.json

ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore_global ~/.gitignore_global

sublime_user_dir="$HOME/Library/Application Support/Sublime Text/Packages/User"
sublime_dotfiles_dir="$HOME/dotfiles/apps/sublime/User"
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
brew bundle --file=~/dotfiles/Brewfile || echo "[warn] brew bundle failed, continuing..."

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
