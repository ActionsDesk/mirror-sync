#!/bin/bash
git fetch --all

remote_branches=$(git branch --all | grep remotes/remote/)

echo "Remote branches:"
echo "$remote_branches"

# Loop through all remote branches
for remote_branch_ref in $remote_branches; do
  # Get the remote branch name
  remote_branch_name=${remote_branch_ref#remotes/remote/}
  
  # Checkout if remote branch exists on mirror
  git rev-parse --verify remotes/origin/"$remote_branch_name"
  result_code=$?

  # If branch exists on mirror, pull changes from remote repository into it
  # If branch does not exist on mirror, create it from remote repository
  if [ $result_code -eq 0 ]; then
    git checkout -B "$remote_branch_name" remotes/origin/"$remote_branch_name"
    git pull --no-rebase --no-edit remote "$remote_branch_name"
  else
    git checkout -b "$remote_branch_name" "$remote_branch_ref"
  fi

  git push origin "$remote_branch_name"
  git push remote "$remote_branch_name"
done
