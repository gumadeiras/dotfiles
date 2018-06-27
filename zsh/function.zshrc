# ffd - cd to selected directory
ffd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*'         \
                     -prune                \
                     -o -type d            \
                     -print 2> /dev/null | \
                     fzf +m -x             \
  ) && cd "$dir"
                     # fzf --query="$1" \
}

# ffda - including hidden directories
ffda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m -x) && cd "$dir"
}

# ffh - repeat history
ffh() {
  eval $(history | fzf +s -x| sed 's/ *[0-9]* *//')
}

# ffkill - kill process
ffkill() {
  ps -ef   | \
    sed 1d | \
    fzf -m | \
    awk '{print $2}' | \
    xargs kill -${1:-9}
}

# ffbr - checkout git branch
ffbr() {
  local branches branch
  branches=$(git branch) \
    && branch=$(echo "$branches" | fzf +s +m -x) \
    && git checkout $(echo "$branch" | sed "s/.* //")
}

# ffco - checkout git commit
ffco() {
  local commits commit
  commits=$(git log --pretty=oneline \
                    --abbrev-commit  \
                    --reverse)       \
    && commit=$(echo "$commits" | fzf +s +m -e) \
    && git checkout $(echo "$commit" | sed "s/ .*//")
}