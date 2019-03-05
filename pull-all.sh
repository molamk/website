#!/bin/bash

echo -e "\033[0;32m[*]\tRefreshing all submodules...\033[0m"

git submodule update
git submodule foreach git checkout master
git submodule foreach git pull origin master

echo -e "\033[0;32m[+]\tDone\033[0m"
