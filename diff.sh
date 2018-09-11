#!/bin/bash -x

projects=$(git status -s | grep -v -e "^A" -e "^M" | awk '{print $2}')


for p in $projects
do
  pushd $p
  echo $p
  git diff
  popd
done
