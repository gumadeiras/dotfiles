#!/usr/bin/env bash
echo "[exec] hi :)"
# install xcode coreutils
echo "[exec] installing xcode tools"
xcode-select --install
# http://tech.lauritz.me/caps-lock-as-control-escape/

# Check for Homebrew
if test ! $(which brew)
then
  echo "[exec] installing homebrew"

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

# mkdir -p ~/.vim/plugin
echo "[exec] linking brewfile, zsh, htop, karabiner"
mkdir -p ~/.zsh
ln -f ./Brewfile ~/Brewfile
ln -f ./zsh/zshrc ~/.zshrc
ln -f ./zsh/alias.zsh ~/.zsh/alias.zsh
ln -f ./zsh/functions.zsh ~/.zsh/functions.zsh

mkdir -p ~/.config/htop/
ln -f ./apps/htoprc ~/.config/htop/htoprc

mkdir -p ~/.config/karabiner/
ln -f ./apps/karabiner.json ~/.config/karabiner/karabiner.json

echo "[exec] brew tap"
brew tap homebrew/bundle
brew bundle

# brew link curl --force
# brew linkapps macvim
git lfs install
# /usr/local/opt/fzf/install

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# number_of_cores=$(sysctl -n hw.ncpu)
# bundle config --global jobs $((number_of_cores - 1))

# pip3 install wharfee
echo "[exec] brew/cask cleanup"
brew cleanup
brew cask cleanup
brew doctor
brew cask doctor
brew list

echo "[exec] installing oh-my-zsh"
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "[exec] making zsh the default shell"
chsh -s /bin/zsh

echo "[exec] cloning oh-my-zsh themes, plugins"
cd ~/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
# mkdir -p ~/.tmux/plugins/tpm
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# setup config for iTerm2 http://stackoverflow.com/a/25122646/4298624
echo "[exec] iterm begin"
sh ./apps/iterm/setup.sh

echo "[exec] setting sublime preferences"
sh ./apps/Sublime/sublime.sh

echo "[exec] setting macOS defaults"
sh ./macos-defaults.sh