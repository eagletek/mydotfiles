# find files with non printable characters in them.
function findUnprintable {
    grep '[^[:space:][:print:]]' $@
}

# makes a copy of the file then attempts to overwrite the original
# usage: stripUnprintable FILE1 FILE2 FILE3 ...
function stripUnprintable {
    for file in $@; do
      tr -dc '\11\12\15\40-\176' < $file > "$file.mod"
      mv "$file.mod" $file
    done
}


