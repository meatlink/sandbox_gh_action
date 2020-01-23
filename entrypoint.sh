#!/bin/sh -l

main () {
    pwd ; ls
    generate_jekyll_site
    generate_mdbook_content
    replace_content
    commit_updated_files
    ls
}

generate_jekyll_site () {
    (
        cd master_branch
        bundle exec jekyll build
    )
}

generate_mdbook_content () {
    (
        . $HOME/.cargo/env
        cd master_branch/book
        mdbook build
    )
}

replace_content () {
    test -e pages_branch/build && rm -rf pages_branch/build
    mv master_branch/_site pages_branch/build
    test -e pages_branch/build/book && rm -rf pages_branch/build/book
    mv master_branch/book/book pages_branch/build/book
}


commit_updated_files () {
    (
        cd pages_branch
        git add -A
        # TODO: commit
        git status
    )
}

main
