#!/usr/bin/env bash


alias git='noglob git'
alias cl=clear

alias pst=pstorm

alias -g oo='open "."'

alias rm='nocorrect rm'

alias brewu='brew update && brew unlink php56 && brew unlink php70 && brew unlink php71 && brew link php56 && brew upgrade | 2>&1 && brew unlink php56 && brew link php70 && brew upgrade | 2>&1 && brew unlink php70 && brew link php71 && brew upgrade | 2>&1 && brew cleanup && brew prune && brew doctor'
