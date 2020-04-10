#!/usr/bin/zsh

# slightly improved autojump command: when a valid path is given,
# jump to that path instead of looking into the autojump database...
j () {
    output=$(echo $@)
    [ ! -d "$output" ] && output=$(autojump $@)
    if [[ -d "$output" ]]; then
        echo -e "\\033[31m${output}\\033[0m"
        cd "$output"
    else
        echo -e "\\033[31m.\\033[0m"
    fi
}

# slightly improved autojump command: when a valid path is given,
# jump to that path instead of looking into the autojump database...
# also, don't jump to folders not contained in current folder.
jc () {
    output=$(echo $(pwd)/$@)
    [ ! -d "$output" ] && output=$(autojump $(pwd) $@)
    if [[ $output == *"$(pwd)"* && -d "$output" ]];then
        echo -e "\\033[31m${output}\\033[0m"
        cd "$output"
    else
        echo -e "\\033[31m.\\033[0m"
    fi
}

# an autojump-like method for "jumping" into a directory based on fzf:
# advantage: see where you are going to jump before actually jumping
f () {
    output=$(autojump --stat | head --lines=-7 | sed 's/.*:[ \t]*//g' | fzf)
    if [[ -d "${output}" ]]; then
        echo -e "\\033[31m${output}\\033[0m"
        cd "${output}"
    else
        echo -e "\\033[31m.\\033[0m"
    fi
}

# an autojump-like method for "jumping" into a directory based on fzf:
# advantage: see where you are going to jump before actually jumping
fc () {
    output=$(find . -maxdepth 3 -type d 2> /dev/null | fzf)
    if [[ -d "${output}" ]]; then
        echo -e "\\033[31m${output}\\033[0m"
        cd "${output}"
    else
        echo -e "\\033[31m.\\033[0m"
    fi
}

# an autojump-like method for "jumping" into a directory based on fzf:
# advantage: see where you are going to jump before actually jumping
ff () {
    file=$(find $HOME  -maxdepth 3 -type f 2> /dev/null | fzf)
    [ $? -ne 0 ] && return
    output=$(dirname $file)
    if [[ -d "${output}" ]]; then
        echo -e "\\033[31m${output}\\033[0m"
        cd "${output}"
    else
        echo -e "\\033[31m.\\033[0m"
    fi
}

