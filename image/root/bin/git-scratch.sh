#!/bin/sh

MASTER_BRANCH="${1}" &&
    git diff --exit-code &&
    git diff --cached --exit-code &&
    [ -z "$(git ls-files --other --exclude-standard --directory)" ] &&
    git fetch upstream "${MASTER_BRANCH}" &&
    git checkout "upstream/${MASTER_BRANCH}" &&
    git checkout -b scratch/$(uuidgen)