function f --description 'f <ext> <pat>: grep inside files with extension'
    grep -n "$argv[2..-1]" **.$argv[1]
end

