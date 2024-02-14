#!/bin/bash

export PATH="~/.local/bin:~/.local/share/fnm:$PATH"
eval "`fnm env`"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lA'
alias cd='cd -P'
alias grep='grep --color=auto'

function git-branch {
    git rev-parse --abbrev-ref HEAD 2> /dev/null || echo -n
}

OLD_PS1=$PS1
PS1='\[\e[93m\][\[\e[96m\]\u\[\e[93m\](λ)\[\e[96m\]\h \[\e[92m\]\W\[\e[93m\]]\[\e[93m\] `git-branch`\n\[\e[93m\]\$ \[\e[92m\]>> \[\e[0m\]'
