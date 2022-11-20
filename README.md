# Git Docker

This project produces git binaries and docker images using sources located at
https://github.com/git/git with the following goals:

 * Provide an easy way to get the latest version of git
 * Provide both glibc and musl linked versions of git
 * Provide amd64 and arm64 versions of git for Linux

## How do I get the latest version of git into my docker image?

For glibc based distributions, add the following to your Dockerfile
```dockerfile
COPY --from=truemark/git:latest /usr/local/ /usr/local/
```

For musl based distributions, like Alpine Linux, add the following to your Dockerfile
```dockerfile
COPY --from=truemark/git:latest-musl /usr/local/ /usr/local/
```

## What dependencies are required for git to work?

The following dependencies are needed in Ubuntu and Debian for git.
```bash
apt-get -qq update && apt-get -qq install --no-install-recommends libcurl4 libexpat1 ca-certificates openssh-client
```

The following dependencies are needed in Alpine Linux for git to work
```bash
apk add libintl libcurl openssh-client
```

The following dependencies are needed in Amazon Linux for git to work

```bash
yum -q -y install ssh-clients
```

If you do not need to work with git repositories over ssh, you can leave off the ssh dependencies.

## Maintainers

 - [erikrj](https://github.com/erikrj)

## License

The contents of this repository are released under the BSD 3-Clause license. See the
license [here](https://github.com/truemark/git-docker/blob/main/LICENSE.txt).


