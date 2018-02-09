set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR vim
set -gx NUM_CORES (cat /proc/cpuinfo | grep processor | wc -l)
set -gx PATH . $HOME/bin $PATH

# command timer
set fish_command_timer_color 999
