# Git Aliases
alias cdr='cd $(git rev-parse --show-cdup)'
alias gs='git status'
alias gts='gtm status'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gi='vim .gitignore'
alias gcm='git ci -m'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias gt='git tag'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gmm='git merge --no-edit'
alias gmne='git merge --no-edit --no-ff'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias gf='git fetch'
alias gd='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias gdd='git diff'
alias gd1='gd HEAD~1..HEAD'
alias gd2='gd HEAD~2..HEAD'
alias gd3='gd HEAD~3..HEAD'
alias gb='git b'
# Staged and cached are the same thing
alias gbd='git b -D -w'
alias gdc='git diff --cached -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias guiu='git update-index --assume-unchanged'
alias guic='git update-index --no-assume-unchanged'
alias guil='git ls-files -v|grep "^h"'
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# git merge (no-ff) master or passed in branch with current one, push, and get back
function gpb () {
    local current=$(git rev-parse --abbrev-ref HEAD)
    local branch="master"
    if [ $1 ]; then
        branch=$1
    fi
    git checkout "$branch"
    git merge ${current} --no-ff --no-edit
    git push
    git checkout ${current}
}

# push and track current branch with origin
function gpnb () {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git push -u origin "$branch"
}

function ginit () {
  if [ $1 ]; then
      title=$1
  else
      pwd=$(pwd)
      title=$(basename "$pwd")
  fi
  git init
  gtm init
  echo "# $title" > README.md
  git add .
  git commit -m 'init'
}


function git {
   local tmp=$(mktemp -t git)
   local repo_name

   if [ "$1" = clone ] ; then
     command git "$@" --progress 2>&1 | tee $tmp
     repo_name=$(awk -F\' '/Cloning into/ {print $2}' $tmp)
     rm -f $tmp
     printf "changing to directory %s\n" "$repo_name"
     cd "$repo_name"
   else
     command git "$@"
   fi
}
