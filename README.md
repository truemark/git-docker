# GIT Docker Image

Many Linux distributions have large dependencies on in their git packages which
are undesirable when building small optimized docker images. This project
aims to build a minimal git and git-crypt binaries inside a docker image you
can use to copy into your own docker images without needing the distribution
provided git package.

## How do I use this image?

To include git and git-crypt from this image into your docker image, insert
the following code into your Dockerfile.

```
COPY --from=truemark/git:amazonlinux-2 /usr/local/ /usr/local/
```

Replace the "amazonlinux-2" part of the tag with the distribution that best
matches the base docker image you are using. If there isn't a distribution
that works for your use case, submit an Issue requesting it to 
https://github.com/truemark/git-docker/issues. 


