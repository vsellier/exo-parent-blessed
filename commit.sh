#!/bin/bash -x

projects=$(git status -s | grep -v -e "^A" -e "^M" | awk '{print $2}')

MSG="$*"

for p in $projects
do
  pushd $p
  echo $p
  git add -A
  git commit -m "${MSG}"
  gitk --all
  popd
done
