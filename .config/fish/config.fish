set -g fish_key_bindings fish_vi_key_bindings
set -x NUM_CORES (cat /proc/cpuinfo | grep processor | wc -l)
