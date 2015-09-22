#!/usr/bin/env bash

# Add some useful aliases
if [ -f /home/vagrant/.bashrc ]; then
cat <<EOF >> /home/vagrant/.bashrc
# Show human friendly numbers and colors
alias df='df -h'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias du='du -h -d 2'

# Git Flow Aliases
alias gfi="git flow init"
alias gff="git flow feature"
alias gffs="git flow feature start"
alias gffp="git flow feature publish"
alias gffpub="git flow feature publish"
alias gfff="git flow feature finish"
alias gffco="git flow feature checkout"
alias gfr="git flow release"
alias gfrs="git flow release start"
alias gfrp="git flow release pubish"
alias gfrpub="git flow release pubish"
alias gfrf="git flow release finish"
alias gfh="git flow hotfix"
alias gfhs="git flow hotfix start"
alias gfhp="git flow hotfix publish"
alias gfhpub="git flow hotfix publish"
alias gfhf="git flow hotfix finish"
alias gfs="git flow support"

# Git Aliases
alias gs='git status'
alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
alias gcm='git ci -m'
alias gcam='git ci -am'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias glg='git l'
alias glog='git l'
alias co='git co'
alias gf='git fetch'
alias gfch='git fetch'
alias gd='git diff'
alias gb='git b'
alias gbd='git b -D -w'
alias gdc='git diff --cached -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gplom='git pull origin master'
alias gplod='git pull origin develop'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gt='git t'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias grestore='!f() { git checkout $(git rev-list -n 1 HEAD -- $1)~1 -- $(git diff --name-status $(git rev-list -n 1 HEAD -- $1)~1 | grep "^D" | cut -f 2); }; f'

# Common shell functions
alias less='less -r'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'
alias cl='clear'

# show me files matching "ls grep"
alias lsg='ll | grep'
alias kss='/var/www/html/styleguides/node_modules/.bin/kss-node'
EOF
fi