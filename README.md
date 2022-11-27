# Git Docker

This project produces a set of single layer docker images for amd64 and arm64
containing the latest version of git for a number of Linux distributions.

## How do I get the latest version of git into my docker image?


For Amazon versions

```dockerfile
COPY --from=truemark/git:amazonlinux-2022 /usr/local/ /usr/local/
```

```dockerfile
COPY --from=truemark/git:amazonlinux-2 /usr/local/ /usr/local/
```

For Alpine versions

```dockerfile
COPY --from=truemark/git:alpine-3.17 /usr/local/ /usr/local/
```

```dockerfile
COPY --from=truemark/git:alpine-3.16 /usr/local/ /usr/local/
```

For Ubuntu versions

```dockerfile
COPY --from=truemark/git:ubuntu-jammy /usr/local/ /usr/local/
```

```dockerfile
COPY --from=truemark/git:ubuntu-focal /usr/local/ /usr/local/
```

For Debian versions

```dockerfile
COPY --from=truemark/git:debian-bookworm /usr/local/ /usr/local/
```

```dockerfile
COPY --from=truemark/git:debian-bullseye /usr/local/ /usr/local/
```

```dockerfile
COPY --from=truemark/git:debian-buster /usr/local/ /usr/local/
```

## What dependencies are required for git to work?

You need to have libcurl and libexpat1 installed for Ubuntu and Debian systems

For Ubuntu & Debian
```bash
apt-get -qq install --no-install-recommends libcurl4 libexpat1
```

Additionally, if you want to use git with SSH, you need to have an SSH client installed

```bash
yum -y install ssh-clients
```

```bash
apk add --no-cache openssh-client
```

```bash
apt-get -qq install --no-install-recommends openssh-client
```

## Maintainers

 - [erikrj](https://github.com/erikrj)

## License

The contents of this repository are released under the BSD 3-Clause license. See the
license [here](https://github.com/truemark/git-docker/blob/main/LICENSE.txt).


