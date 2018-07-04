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
- oh-my-zsh + .profile
- set macOS defaults (10.13.5)
- set Sublime pkgs + preferences path
- set Karabiner preferences path
- set htop preferences path

. extras in ./apps
- iTerm 2.app preferences
- Alfred.app preferences
- BetterTouchTool.app preset
- Sublime pkgs/prefs linking ./Sublime/sublime.sh

some changes might be necessary (git username, etc) if you want to use this.

. todo:
- setup python env using conda (currently macports)
- setup deep learning env (move to conda/pip)