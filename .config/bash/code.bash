# -------------
# build related
# -------------
# run gradle wrapper in current git repo
function gr()
{
    root=$(git rev-parse --show-toplevel) || return

    cd "$root"
    ./gradlew "$@"
    cd -
}
