#!/bin/sh

set -e
set -u


main () {
    pwd ; ls ; id
    generate_jekyll_site
    generate_mdbook_content
    replace_content
    commit_updated_files
}

generate_jekyll_site () {
    (
        cd "$CHIPMUNKDOCS_SRC_DIR"
        bundle exec jekyll build
    )
}

generate_mdbook_content () {
    (
        cd "${CHIPMUNKDOCS_SRC_DIR}/book"
        /mdbook build
    )
}

replace_content () {
    local dest_dir
    dest_dir="${CHIPMUNKDOCS_DEST_DIR}/build"
    replace_site_content
    add_mdbook_to_site
}

replace_site_content () {
    test -e "$dest_dir" && rm -rf "$dest_dir"
    mv "${CHIPMUNKDOCS_SRC_DIR}/_site" "$dest_dir"
}

add_mdbook_to_site () {
    test -e "${dest_dir}/book" && rm -rf "${dest_dir}/book"
    mv "${CHIPMUNKDOCS_SRC_DIR}/book/book" "${dest_dir}/book"
}

commit_updated_files () {
    (
        cd pages_branch
        #git add -A
        # TODO: commit
        #git status
        #git diff --staged
    )
}


main
