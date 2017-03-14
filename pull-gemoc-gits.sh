#!/bin/env bash
set -e

UPDATE=false
while getopts ":u" opt; do
  case $opt in
    u)
      UPDATE=true
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
