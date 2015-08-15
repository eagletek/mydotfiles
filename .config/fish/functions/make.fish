function make
    command make -j (math $NUM_CORES - 1) $argv
end

function mi
    make install
end

function mc
    make clean
end
