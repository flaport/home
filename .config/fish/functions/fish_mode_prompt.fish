#    _____ _     ____  ____  ____  ____  _____ 
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \  
#   | |   | |_/\| |-|||  __/| \_/||    /  | |  
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/  
#
function fish_mode_prompt --description 'Displays the current mode'
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold red
                echo "*"
            case replace_one
                set_color --bold blue
                echo "r"
            case visual
                set_color --bold brmagenta
                echo "v"
            case insert
                set_color green
                echo "─"
            case "─"
                echo "─"
        end
        set_color normal
    end
end
