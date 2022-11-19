#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_VERSION=$(curl -sSL https://api.github.com/repos/git/git/tags | jq -r "[.[].name | select(contains(\"-rc\") | not)] | .[0]")
echo "Using git version ${GIT_VERSION}"

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  --platform linux/arm64 \
  -f amazonlinux.Dockerfile \
  -t truemark/git:amazonlinux-beta-${GIT_VERSION} \
  -t truemark/git:amazonlinux-beta \
  -t truemark/git:beta \
  .

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  --platform linux/arm64 \
  -f alpine.Dockerfile \
  -t truemark/git:alpine-beta-${GIT_VERSION} \
  -t truemark/git:alpine-beta \
  .
