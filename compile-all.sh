#!/bin/env bash
set -e

LOCALREPO="$PWD/localm2"
UPDATE=false

while getopts ":uoh" opt; do
  case $opt in
    u)
      UPDATE=true
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


function retrieve_git_repo {
	if [ -d "$1" ]; then
		if [ $UPDATE = true ]; then
			cd $1
			echo "Performing \"git update\" in \"$1\"..."
			git pull
			cd ..
		else
			echo "\"$1\" folder already exists, not cloning. Pass option -u to perform \"git update\" in each folder first."
		fi
	else
		git clone "$2"
	fi
}


# Retrieving all the source code upstream
retrieve_git_repo "ModelDebugging" "https://github.com/SiriusLab/ModelDebugging"
retrieve_git_repo "gemoc-studio" "https://github.com/gemoc/gemoc-studio"
retrieve_git_repo "concurrency" "https://github.com/gemoc/concurrency"
retrieve_git_repo "coordination" "https://github.com/gemoc/coordination"
retrieve_git_repo "gemoc-studio.wiki" "https://github.com/gemoc/gemoc-studio.wiki.git"

# Starting compilation using dedicated pom.xml
mvn package -Dmaven.repo.local=$LOCALREPO -P 'ignore_CI_repositories,!use_CI_repositories' $OFFLINEARG
