#!/bin/bash -x

projects=$(git status -s | grep -v -e "^A" -e "^M" | awk '{print $2}')

ACTION=$*

for p in $projects
do
  pushd $p
  echo $p
  git push ${ACTION}
  gitk --all
  popd
done
