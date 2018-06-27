#!/usr/bin/env bash

# install xcode coreutils
xcode-select --install
# http://tech.lauritz.me/caps-lock-as-control-escape/
# install first: homebrew
echo "installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "installing oh-my-zsh"
# install oh-my-zsh
zsh < <(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

# mkdir -p ~/.vim/plugin
echo "creating zsh links over at ~/"
mkdir -p ~/.zsh
ln -f ./Brewfile ~/Brewfile
ln -f ./zsh/zshrc ~/.zshrc
ln -f ./zsh/alias.zsh ~/.zsh/alias.zsh
ln -f ./zsh/functions.zsh ~/.zsh/functions.zsh

# cp -i ./Brewfile ~/Brewfile
# cp -i ./zsh/zshrc ~/.zshrc
# cp -i ./zsh/alias.zsh ~/.zsh/alias.zsh
# cp -i ./zsh/functions.zsh ~/.zsh/functions.zsh


echo "brew tap"
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
brew cleanup
brew cask cleanup
brew doctor
brew cask doctor
brew list

echo "[exec] cloning ohmyzsh themes, plugins"
cd ~/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
# mkdir -p ~/.tmux/plugins/tpm
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# setup config for iTerm2 http://stackoverflow.com/a/25122646/4298624
echo "[exec] iterm begin"
sh ./apps/iterm/setup.sh
echo "[exec] setting macOS defaults"
sh ./macos-defaults.sh