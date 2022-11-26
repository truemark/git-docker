#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_VERSION=$(curl -sSL https://api.github.com/repos/git/git/tags | jq -r "[.[].name | select(contains(\"-rc\") | not)] | .[0] | sub(\"v\";\"\")")
echo "Using git version ${GIT_VERSION}"

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg OS_VERSION="2" \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  -f amazonlinux.Dockerfile \
  -t truemark/git:beta-${GIT_VERSION}-amazonlinux-2 \
  -t truemark/git:beta-amazonlinux-2 \
  .
IMAGE="truemark/git:beta-${GIT_VERSION}" ARCH="amd64" FILE="git-amazonlinux-2-amd64.tar.gz" ./getlayer.sh
IMAGE="truemark/git:beta-${GIT_VERSION}" ARCH="arm64" FILE="git-amazonlinux-2-arm64.tar.gz" ./getlayer.sh
