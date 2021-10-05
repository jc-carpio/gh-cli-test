#!/bin/bash


echo Hello, what /do you want to name the release? \(e.g 2.3.1\)
read version

$version

json -I -f package.json -e "this.version=\"$version\""

git add \.
git commit -m "bump  version to $version"