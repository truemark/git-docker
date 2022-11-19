#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_VERSION=$(curl -sSL https://api.github.com/repos/git/git/tags | jq -r "[.[].name | select(contains(\"-rc\") | not)] | .[0]")
echo "Using git version ${GIT_VERSION}"
export GIT_CRYPT_VERSION=$(curl -sSL https://api.github.com/repos/AGWA/git-crypt/tags | jq -r "[.[].name | select(contains(\"debian\") | not)] | .[0]")
echo "Using git-crypt version ${GIT_CRYPT_VERSION}"

docker buildx build \
  --builder beta \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  --push \
  --platform linux/arm64,linux/amd64 \
  -f amazonlinux.Dockerfile \
  -t truemark/git:amazonlinux-2-beta .
