function valgrind
    command valgrind --track-origins=yes --leak-check=full $argv
end
