function gitbranches
    for dir in (ls)
        if [ -d $dir ]
            cd $dir
            if [ -d .git ]
                echo "$dir:" (git rev-parse --abbrev-ref HEAD)
            end
            cd -
        end
    end
end

