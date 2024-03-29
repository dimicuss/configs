#!/bin/bash

export PATH="~/.yarn/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if type nvm &> /dev/null
then
    [ ! -f ~/.nvmrc ] && echo "lts/*" > ~/.nvmrc
    if ! type node &> /dev/null
    then
        nvm install &> /dev/null
        nvm use &> /dev/null
    fi
fi

if type git &> /dev/null
then
    git config --global user.email "dimicuss@gmail.com"
    git config --global user.name "dimicuss"
    git config --global core.editor "emacs -Q"
    git config --global commit.template ~/.gitmessage
    echo 'feat(frontend): ; ref #' > ~/.gitmessage    
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

autocomp=/usr/share/bash-completion/bash_completion
[ -f $autocomp ] && source $autocomp

alias ls='ls --color=auto'
alias ll='ls -lA'
alias cd='cd -P'
alias vp_on='sudo systemctl start openvpn-client@client'
alias vp_st='sudo systemctl status openvpn-client@client'
alias vp_off='sudo systemctl stop openvpn-client@client'
alias gp='git pull && git push'
alias gac='git add "$(git rev-parse --show-toplevel)" && git commit'
alias grep='grep --color=auto'

function get-top-level {
    git rev-parse --show-toplevel 2> /dev/null | sed -E 's~.*\/(.*)$~(Top level: \1)~'
}

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

function rpls {
    local OPTIND p s d=0
    while getopts 'dp:s:' key
    do
        case "$key" in
            p) p="$OPTARG" ;;
            s) s="$OPTARG" ;;
            d) d=1 ;;
            *) return ;;
        esac
    done
    
    shift $((OPTIND - 1))

    if ((d == 1))
    then
        grep -l -Z -E "$p" -r $@ | xargs -0 sed -i -E "s~$p~$s~"
    else
        grep -H -E "$p" -r $@ | while read match
        do
            echo           
            echo "File: $(echo "$match" | cut -d : -f1)"            
            echo "Match: $(echo "$match" | cut -d : -f2-)"            
            [ ! -z $s ] && echo "Replacing: $(echo "$match" | cut -d : -f2- | sed -E "s~$p~$s~")"
        done        
    fi    
}

function rnm-sngl-indx {
    local original_dir=$(pwd)
    find $@ -regextype posix-extended -regex '^.*index(\.[[:alnum:]]+)?$' | while read path
    do
        local index_real_path=$(realpath "$path")
        local index_dir=$(dirname "$index_real_path")
        if (($(ls -A "$index_dir" | wc -w) == 1))
        then
            local bn=$(basename "$index_real_path")
            local ext=$(echo "$index_real_path" | sed -E 's~.*(\..+)~\1~')
            local temp_filename="$index_dir$ext~temp"
            mv "$index_real_path" "$temp_filename"
            rmdir "$index_dir"
            mv "$temp_filename" "$index_dir$ext"
        fi
    done
    cd "$original_dir"
}

function prompt_command {
    local extension="$(join-commands get-top-level get-branch "get-code $?")"
    PS1="\[\e[93m\][\[\e[94m\]\u\[\e[93m\](λ)\[\e[94m\]\h \[\e[36m\]\W\[\e[93m\]]\[\e[93m\] $extension\n\[\e[93m\]\\\$ \[\e[92m\]>> \[\e[0m\]"
}

PROMPT_COMMAND='prompt_command'

