#!/bin/env bash
set -e

LOCALREPO="$PWD/localm2"

# Make sure all the submodules are up-to-date
# git submodule update --remote

mvn package -Dmaven.repo.local=$LOCALREPO -P 'ignore_CI_repositories,!use_CI_repositories'


