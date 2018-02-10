#!/usr/bin/env bash

set -e

git stash
git checkout master
git stash pop
git add SamplePod.podspec
git commit -m "Bump up pod version"
cd Example
pod install
cd ..
git add .
git commit -m "Update sample app"
git tag 0.1.1 -m "v0.1.1"
git push --tags
pod repo push SamplePod

