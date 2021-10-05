#!/bin/bash

# before running this file, run chmod u+x <location of this file>
# run npm i -g json


echo Hello, what /do you want to name the release? \(e.g 2.3.1\)
read version

$version

echo Please paste the redmine link \for the following release \(e.g \"https://projects.hometime.io/projects/control-2-0/issues?query_id=186\"\)
read redmineLink


echo '----> Checking out updated master before creating new release branch'

git checkout master
git pull origin master

git checkout -b release\/$version


echo '----> Editing version in package.json'

json -I -f package.json -e "this.version=\"$version\""

git add package.json
git commit -m "bump version to $version"

git push origin HEAD

echo '----> Creating release PR for ${version}'

gh pr create --title "$version" --body "$redmineLink" --base "master"

gh release create $version --title "$version" --notes "$redmineLink" --target master --draft