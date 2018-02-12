#!/usr/bin/env bash

# exit on error
set -e

branch=master
version=$(awk '{if ($1 == "s.version") print $3}' SamplePod.podspec | sed s/\'//g)

git stash
git checkout $branch
git pull --rebase
git stash pop
git add SamplePod.podspec
git commit -m "Bump up pod version"
cd Example
pod install
cd ..
git add Example
git commit -m "Update sample app"
git tag $version -m "v$version"
git push --tags
pod repo push SamplePod
