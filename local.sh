#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

GIT_VERSION="2.34.1"
GIT_CRYPT_VERSION="0.6.0"

docker buildx build \
  --builder beta \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  --push \
  --platform linux/arm64,linux/amd64 \
  -f amazonlinux.Dockerfile \
  -t truemark/git:amazonlinux-2-beta .
