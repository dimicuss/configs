#!/bin/bash

export PATH="~/.local/bin:~/.local/share/fnm:$PATH"
which fnm &> /dev/null && eval "`fnm env`"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lA'
alias cd='cd -P'
alias vp_on='sudo systemctl start openvpn-client@client'
alias vp_st='sudo systemctl status openvpn-client@client'
alias vp_off='sudo systemctl stop openvpn-client@client'
alias gp='git pull && git push'
alias grep='grep --color=auto'

function get-branch {
    git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -E 's~(.*)~(Branch: \1)~'
}

function get-code {
    local last_code="$1"
    [ $last_code != "0" ] && echo $last_code | sed -E 's~(.*)~(Code: \1)~'
}

function join-commands {
    local i=1
    for command in "$@"
    do
        local result="$(eval "$command")"
        local postfix="$([ $i != $# ] && echo " ")"
        [ -n "$result" ] && echo -n "$result$postfix"
        i=$((i + 1))
    done
}

function prompt_command {
    local extension="$(join-commands get-branch "get-code $?")"
    PS1="\[\e[93m\][\[\e[96m\]\u\[\e[93m\](λ)\[\e[96m\]\h \[\e[92m\]\W\[\e[93m\]]\[\e[93m\] $extension\n\[\e[93m\]\\\$ \[\e[92m\]>> \[\e[0m\]"
}

PROMPT_COMMAND='prompt_command'

