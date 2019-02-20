function fish_prompt
	
    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end
    and set retc green
    or set retc red

# start prompt
    set_color $retc
    echo -n '┬─'

# start [username@host:~/path]
    set_color -o green
    echo -n [

# username
#   if test "$USER" = root -o "$USER" = toor
#       set_color -o red
#   else
#       set_color -o yellow
#   end
#   echo -n $USER

# host
#   set_color -o white
#   echo -n @
#   if [ -z "$SSH_CLIENT" ]
#       set_color -o blue
#   else
#       set_color -o cyan
#   end
#   echo -n (prompt_hostname)
#   set_color -o red
#   echo -n :

# path
    set_color -o yellow
    echo -n (prompt_pwd)

# end [username@host:~/path]
    set_color -o green
    echo -n ']'

# date
#   _nim_prompt_wrapper $retc '' (date +%X)

# virtual environment
#   set -q VIRTUAL_ENV
#   and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")

# git
    set prompt_git (__fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc git $prompt_git

# battery status
#   type -q acpi
#   and test (acpi -a 2> /dev/null | string match -r off)
#   and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

# new line
    echo

# background jobs
    set_color normal
    for job in (jobs)
        set_color $retc
        echo -n '    │ ' # change number of spaces here if vim keys are set/unset
        set_color brown
        echo $job
    end

# prompt
    set_color normal
    set_color $retc
    echo -n '    ╰─>'
    set_color -o blue
    echo -n '$ '
    set_color normal
end
