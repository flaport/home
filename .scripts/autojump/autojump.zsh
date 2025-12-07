#!/usr/bin/zsh

export AUTOJUMP_SOURCED=1
export AUTOJUMP_ERROR_PATH=~/.local/share/autojump/errors.log
if [[ ! -d ${AUTOJUMP_ERROR_PATH:h} ]]; then
    mkdir -p ${AUTOJUMP_ERROR_PATH:h}
fi


# change pwd hook
autojump_chpwd() {
    if [[ -f "${AUTOJUMP_ERROR_PATH}" ]]; then
        autojump --add "$(pwd)" >/dev/null 2>>${AUTOJUMP_ERROR_PATH} &!
    else
        autojump --add "$(pwd)" >/dev/null &!
    fi
}

typeset -gaU chpwd_functions
chpwd_functions+=autojump_chpwd


# default autojump command
j() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    fi

    setopt localoptions noautonamedirs
    local output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        if [ -t 1 ]; then  # if stdout is a terminal, use colors
                echo -e "\\033[31m${output}\\033[0m"
        else
                echo -e "${output}"
        fi
        cd "${output}"
    else
        echo "autojump: directory '${@}' not found"
        echo "\n${output}\n"
        echo "Try \`autojump --help\` for more information."
        false
    fi
}


# jump to child directory (subdirectory of current path)
jc() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    else
        j $(pwd) ${@}
    fi
}


# open autojump results in file browser
jo() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    fi

    setopt localoptions noautonamedirs
    local output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        case ${OSTYPE} in
            linux*)
                xdg-open "${output}"
                ;;
            darwin*)
                open "${output}"
                ;;
            cygwin)
                cygstart "" $(cygpath -w -a ${output})
                ;;
            *)
                echo "Unknown operating system: ${OSTYPE}" 1>&2
                ;;
        esac
    else
        echo "autojump: directory '${@}' not found"
        echo "\n${output}\n"
        echo "Try \`autojump --help\` for more information."
        false
    fi
}


# open autojump results (child directory) in file browser
jco() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    else
        jo $(pwd) ${@}
    fi
}

