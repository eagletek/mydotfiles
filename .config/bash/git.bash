git-branchstatus() {
    cur=$(git rev-parse --abbrev-ref HEAD)
    refs=($(git for-each-ref --format="%(refname:short)" refs/heads))
    for ref in "${refs[@]}"; do
        [[ "${cur}" == "${ref}" ]] && continue
        rev_list_out=$(git rev-list --left-right ${cur}...${ref})
        ahead=$(echo $rev_list_out | grep -o "<" | wc -l)
        behind=$(echo $rev_list_out | grep -o ">" | wc -l)
        echo "[${behind}|${ahead}] ${ref}"
    done
}
