#!/bin/env bash
set -e

LOCALREPO="$PWD/localm2"
UPDATE=false

while getopts ":uoh" opt; do
  case $opt in
    u)
      UPDATEARG='-u'
      
      ;;
    o)
      OFFLINEARG='-o'
      ;;
    h)
      echo "Options:"
      echo "-u: perform \"git update\" in each folder first."
      echo "-o: run maven in offline mode, to avoid fetching everything online (requires a first online build)"
      echo "-h: display this help"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

bash pull-gemoc-gits.sh $UPDATEARG

# Starting compilation using dedicated pom.xml
mvn package -Dmaven.repo.local=$LOCALREPO -P 'ignore_CI_repositories,!use_CI_repositories' $OFFLINEARG
