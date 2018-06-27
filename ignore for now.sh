#!/usr/bin/env bash

# http://tech.lauritz.me/caps-lock-as-control-escape/
# install first: homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install oh-my-zsh
zsh < <(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

# mkdir -p ~/.vim/plugin
mkdir -p ~/.zsh
ln -sf ./vim/abbreviation.vim  ~/.vim/plugin/abbreviation.vim
ln -sf ./Brewfile              ~/Brewfile
ln -sf ./gemrc                 ~/.gemrc
ln -sf ./irbrc                 ~/.irbrc
ln -sf ./pryrc                 ~/.pryrc
ln -sf ./psqlrc                ~/.psqlrc
ln -sf ./tmux.conf             ~/.tmux.conf
ln -sf ./vim/vimrc             ~/.vimrc
ln -sf ./zshrc                 ~/.zshrc
ln -sf ./lftprc                ~/.lftprc
ln -sf ./zsh/alias.zsh         ~/.zsh/alias.zsh
ln -sf ./zsh/functions.zsh     ~/.zsh/functions.zsh
ln -sf ./bin/git-churn         /usr/local/bin/

brew tap homebrew/bundle
brew bundle

brew link curl --force
# brew linkapps macvim
git lfs install
# /usr/local/opt/fzf/install

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# number_of_cores=$(sysctl -n hw.ncpu)
# bundle config --global jobs $((number_of_cores - 1))

# pip3 install wharfee

cd ~/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
# mkdir -p ~/.tmux/plugins/tpm
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone git://github.com/zsh-users/zsh-autosuggestions \
  $ZSH_CUSTOM/plugins/zsh-autosuggestions
# setup config for iTerm2 http://stackoverflow.com/a/25122646/4298624