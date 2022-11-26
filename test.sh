#!/usr/bin/env bash

set -euo pipefail

echo "Initializing git config"
git config --global init.defaultBranch "main"
git config --global user.email "test@example.com"
git config --global user.name "Test Some"

echo "Testing local git repository"
mkdir -p /test && cd /test
git init
TEST_TEXT="This is just a test"
echo -n $TEST_TEXT > test.txt
git add test.txt
git commit -a -m "Adding test file"
rm -rf /test

echo "Testing clone from public repository"
mkdir -p /test && cd /test
git clone -c advice.detachedHead=false --single-branch --depth 1 https://github.com/git/git.git
