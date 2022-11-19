# GIT

This project produces git binaries and docker images using sources located at
https://github.com/git/git with the following goals:

 * Provide an easy way to get the latest version of git
 * Provide both glibc and musl linked versions of git
 * Provide amd64 and arm64 versions of git for Linux
 * Reduce unwanted dependencies by not using a package manager

## How do I get the latest version of git into my docker image?

For glibc based distributions, add the following to your Dockerfile
```
COPY --from=truemark/git:latest /usr/local/ /usr/local/
```

For musl based distributions, like Alpine Linux, add the following to your Dockerfile
```
COPY --from=truemark/git:latest-musl /usr/local/ /usr/local/
```

## Maintainers

 - [erikrj](https://github.com/erikrj)

## License

The contents of this repository are released under the BSD 3-Clause license. See the
license [here](https://github.com/truemark/git-docker/blob/main/LICENSE.txt).


