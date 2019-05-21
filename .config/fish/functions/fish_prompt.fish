#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
#

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
        and echo -n $field_name
#       set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end
    and set retc green
    or set retc red

# start prompt
    set_color $retc
    echo -n '┬─'

# battery status 🔌🔋
    if test (echo (acpi -b 2>/dev/null) | cut -d "D" -f1) = "Battery 0: " # battery is discharging
        set prompt_battery 🔌
        if test (echo (acpi -b 2>/dev/null) | cut -d "D" -f1) = "Battery 0: " # battery is discharging
            set prompt_battery (echo (acpi -b 2>/dev/null) | cut -d "," -f2 | cut -d " " -f2)
        end
        and _nim_prompt_wrapper $retc "" " "$prompt_battery" "
    end

# start [username@host:~/path]
    set_color -o green
    echo -n "─["

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

# path customization
    set_color -o yellow
    #echo -n (prompt_pwd)
    set path (pwd)
    set path (string replace /drives "💾" $path)
    set path (string replace $HOME/.config "⚙" $path)
    set path (string replace $HOME/Notes "📙" $path)
    set path (string replace $HOME/Web "🌐" $path)
    set path (string replace $HOME/Videos "🎬" $path)
    set path (string replace $HOME/Pictures "📷" $path)
    set path (string replace $HOME/Desktop "🗔 " $path)
    set path (string replace $HOME/Latex "🖹" $path)
    set path (string replace $HOME/Downloads "⬇" $path)
    set path (string replace $HOME/Documents "📁" $path)
    set path (string replace $HOME/Python "🐍" $path)
    set path (string replace $HOME "🏠" $path)
    echo -n " "$path" "

# end [username@host:~/path]
    set_color -o green
    echo -n ']'

# date
#   _nim_prompt_wrapper $retc '' (date +%X)

# virtual environment
#   set -q VIRTUAL_ENV
#   and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")

# git 🔗⇄🔃
#   set prompt_git (__fish_git_prompt | string trim -c ' ()')
    set prompt_git (string replace "master" "" (__fish_git_prompt | string trim -c ' ()'))
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc " 🔃" $prompt_git" "

# new line
    echo

# background jobs
    set_color normal
    for job in (jobs)
        set_color $retc
        echo -n ' │ ' # change number of spaces here if vim keys are set/unset
        set_color brown
        echo $job
    end

# prompt $💲➲€
    set_color normal
    set_color $retc
    echo -n ' ╰──>'
    set_color -o blue
    echo -n ' '
    set_color normal
end
