#!/bin/bash

echo -e "\033[0;32m[*]\tDeploying updates to GitHub...\033[0m"

hugo

cd public
git add .

# Commit changes.
msg="Rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master

cd ..

echo -e "\033[0;32m[+]\tDone\033[0m"
