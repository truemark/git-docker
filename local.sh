#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_VERSION=$(curl -sSL https://api.github.com/repos/git/git/tags | jq -r "[.[].name | select(contains(\"-rc\") | not)] | .[0] | sub(\"v\";\"\")")
echo "Using git version ${GIT_VERSION}"

docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=3.16 -f alpine.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=3.17 -f alpine.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=2 -f amazonlinux.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=2022 -f amazonlinux.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=focal -f ubuntu.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=jammy -f ubuntu.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=buster -f debian.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=bullseye -f debian.Dockerfile .
docker build -t moo --build-arg GIT_VERSION=$GIT_VERSION --build-arg OS_VERSION=bookworm -f debian.Dockerfile .
