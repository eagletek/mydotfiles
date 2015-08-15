function up
    set updir .
    for i in (seq 1 $argv[1])
        set updir $updir/..
    end
    cd $updir
end
