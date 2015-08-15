function gitupdate
    for dir in (ls)
        if [ -d $dir ]
            if [ -d {$dir}/.git ]
                cd $dir
                echo " "
                echo "Updating $dir"
                git pull
                cd -
            end
        end
    end
end

