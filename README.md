# hey, dotfiles
dotfiles and some other stuff

. usage:
```sh
git clone https://github.com/gumadeiras/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install.sh
```

. what will this do?
- install Homebrew + packages (see Brewfile)
- install oh-my-zsh + .profile
- set macOS defaults (10.13.5)
- set Sublime.app packages + preferences
- set iTerm2.app preferences
- set Karabiner.app preferences
- set htop preferences

. extras in ./apps
- Alfred.app preferences
- BetterTouchTool.app preset

some changes might be necessary (git username, etc) if you want to use this.

. todo:
- setup python env using conda (currently macports)
- setup deep learning env (move to conda/pip)