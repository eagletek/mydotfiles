function fl --description 'f <ext> <pat>: list files with extension containing match'
    grep -l "$argv[2..-1]" **.$argv[1]
end

