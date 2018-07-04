# hey, dotfiles
dotfiles and some other stuff

. usage:
```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install.sh
```

. what will this do?
- install Homebrew + pkgs (see Brewfile)
- install oh-my-zsh + .profile
- set macOS defaults (10.13.5)
- set iTerm2.app preferences
- set Karabiner preferences
- set htop preferences
- set Sublime pkgs + preferences

. extras in ./apps
- Alfred.app preferences
- BetterTouchTool.app preset

some changes might be necessary (git username, etc) if you want to use this.

. todo:
- setup python env using conda (currently macports)
- setup deep learning env (move to conda/pip)