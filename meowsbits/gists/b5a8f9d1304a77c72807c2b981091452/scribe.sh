#!/usr/bin/env bash

set -e

target_path=${1:-"$HOME/dev/ethereumclassic/ECIPs"}
target_origin=${2:-'ethereumclassic/ECIPS'}
target_fork=${3:-'meowsbits/ECIPs'}
remote_ssh=${4:-'git@github.com'} # meows

if [[ ! -d "$target_path" ]]; then
	mkdir -p "$(dirname $target_path)"
	git clone "meows:$target_origin.git" "$target_path"
	git --git-dir "$target_path/.git" remote add fork "meows:$target_fork"
fi

pushd "$target_path"

git fetch --all
git checkout -B gh

git pull --no-edit fork gh || true

gh-clonepullrequests.sh "$target_origin"
gh-cloneissues.sh "$target_origin"
gh-clonerepoevents.sh "$target_origin"

if git diff-files --quiet; then
	echo "Super quiet on the octocat front... maybe too quiet.. aborting."
	exit 1
fi

files_diff_l="$(git diff-files | grep -v .state | grep -v .etag | wc -l)"
untracked_ls="$(git ls-files --exclude-standard --others | wc -l)"
if [[ $files_diff_l -gt 0 ]] || [[ $untracked_ls -gt 0 ]]; then
        git add .
        git -c 'user.name=meows' -c 'user.email=b5c6@protonmail.com' commit -m "master: $(git rev-parse origin/master)"
        git push fork gh
else
        echo "Quiet on the octocat front."
fi

popd
