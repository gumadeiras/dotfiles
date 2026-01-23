# Personal aliases
# Note: SSH server aliases moved to ~/.ssh/config for better security

# Directory navigation
alias materias="cd ~/Documents/ufrgs/materias"
alias research="cd ~/Documents/research/"
alias papers="cd ~/Documents/research/papers"

# Quick utilities
alias ll="ls -la"
alias h='history'
alias xc='clear'

# Git root
alias root='cd $(git rev-parse --show-cdup)'
# Pretty print the path
alias path="echo $PATH | tr -s ':' '\n'"

# Edit config files
alias vizs="vim ~/.zshrc"
alias ozsh="vim ~/.zsh/alias.zsh"
alias vibrew='vim ~/Brewfile'
alias viconf="vim ~/.vimrc"

# Homebrew aliases
alias b-g='brew upgrade'
alias b-s='brew services'
alias b-u='brew update'

# Ruby/Bundler
alias b='bundle exec'

# Docker helpers
alias dockerip='docker ps | tail -n +2 | while read cid b; do echo -n "$cid\t"; docker inspect $cid | grep IPAddress | cut -d \" -f 4; done'
docker-ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}
alias docker-clean="docker ps -a | grep Exited | awk '{ print \$1; }' | xargs -n1 docker rm"

# Git aliases
alias gdw='git diff --color-words'

# Note: SSH aliases removed for security
# Add your SSH connections to ~/.ssh/config instead:
# Host myserver
#   HostName server.example.com
#   User username
#   Port 22
