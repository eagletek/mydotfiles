function do_unified_diff { export DIFF_STYLE="-u"; }
function do_standard_diff { export DIFF_STYLE=""; }

# conveniences to diff files between deep directory structures
function thisdir { export THIS_DIR="$1"; }
function thatdir { export THAT_DIR="$1"; }
function d {
    if [ -z "$THIS_DIR" ]; then 
        export THIS_DIR="."
    fi

    if [ -z "$THAT_DIR" ]; then
        echo "---Directory to diff against not set. Run 'thatdir'"
        return
    else
        diff $DIFF_STYLE {$THIS_DIR/,$THAT_DIR/}$*
    fi
}

