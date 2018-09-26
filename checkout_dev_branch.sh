#!/usr/bin/env bash

projects=$(find . -type d -maxdepth 1 | grep -v "^.$")

function checkoutBranch() {
  local branch=$1

  git checkout ${branch}
  git pull --tags
}

function checkAndCloneBranchIfPresents() {
  local branch=$1

  echo "  testing ${branch}"
  if [[ $(git ls-remote --heads  $(git remote get-url origin) ${branch} | wc -l) -gt 0 ]]; then
    echo "  ${branch} found" 
    checkoutBranch ${branch}
    return 0
  else
    echo "  ${branch} branch not found"
    return 1
  fi
}

for p in $projects; do
  pushd $p

  echo
  echo $p
  if ! checkAndCloneBranchIfPresents develop; then
    checkAndCloneBranchIfPresents master
  fi

  popd

done
