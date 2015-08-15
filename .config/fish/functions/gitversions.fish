function gitversions --description 'get versions of git repos below current dir'
    for dir in (ls)
        if [ -d $dir ]
            if [ -d {$dir}/.git ]
                if [ -f {$dir}/.version ]
                    cd $dir
                    echo "$dir:" (git describe --tags --dirty --match (cat .version))
                    cd -
                end
            end
        end
    end
end

