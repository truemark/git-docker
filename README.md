# Git Docker

This project produces a set of single layer docker images containing git 
for common Linux distributions on amd64 and arm64.

This project primarily exists because "yum install git" installs a lot
of dependencies including systemd which bloats docker images that use it.

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
RUN apk add --no-cache libcurl
```

```dockerfile
COPY --from=truemark/git:alpine-3.16 /usr/local/ /usr/local/
RUN apk add --no-cache libcurl
```

For Ubuntu versions

```dockerfile
COPY --from=truemark/git:ubuntu-jammy /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4 && rm -rf /var/lib/apt/lists/*
```

```dockerfile
COPY --from=truemark/git:ubuntu-focal /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4 && rm -rf /var/lib/apt/lists/*
```

For Debian versions

```dockerfile
COPY --from=truemark/git:debian-bookworm /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4 && rm -rf /var/lib/apt/lists/*
```

```dockerfile
COPY --from=truemark/git:debian-bullseye /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4 && rm -rf /var/lib/apt/lists/*
```

```dockerfile
COPY --from=truemark/git:debian-buster /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4 && rm -rf /var/lib/apt/lists/*
```

## Dependencies

You will need to have libcurl and an ssh client to clone from https and ssh repositories
respectively.

## Maintainers

 - [erikrj](https://github.com/erikrj)

## License

The contents of this repository are released under the BSD 3-Clause license. See the
license [here](https://github.com/truemark/git-docker/blob/main/LICENSE.txt).


