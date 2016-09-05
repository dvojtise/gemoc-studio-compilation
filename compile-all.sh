#!/bin/env bash
set -e

LOCALREPO="$PWD/localm2"
MVN_CMD_NOPROFILES="mvn install -Dmaven.repo.local=$LOCALREPO"
MVN_CMD="$MVN_CMD_NOPROFILES -P ignore_CI_repositories"
PROGRESSMESSAGE="############## now in $PWD ##################"

# Make sure all the submodules are up-to-date
# git submodule update --remote

# we follow this order: https://ci.inria.fr/gemoc/job/gemoc-studio_gemoc_studio/depgraph-view/

cd gemoc-studio
cd commons 
echo $PROGRESSMESSAGE
$MVN_CMD

cd ../gemoc_commons 
echo $PROGRESSMESSAGE
$MVN_CMD

cd ../../ModelDebugging 
echo $PROGRESSMESSAGE
$MVN_CMD_NOPROFILES -P ignore_CI_repositories,trace_and_framework





