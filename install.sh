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
mkdir -p ~/.config/htop
mkdir -p ~/.config/karabiner

ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/alias.zsh ~/.zsh/alias.zsh
ln -sf ~/dotfiles/zsh/functions.zsh ~/.zsh/functions.zsh

ln -sf ~/dotfiles/apps/htop/htoprc ~/.config/htop/htoprc
ln -sf ~/dotfiles/apps/karabiner.json ~/.config/karabiner/karabiner.json

ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore_global ~/.gitignore_global

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
