function make
    command make -j (math $NUM_CORES - 1) $argv
end
