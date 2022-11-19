FROM alpine:latest AS git-build
ARG GIT_VERSION
RUN apk update && apk add build-base tar curl-dev expat-dev gettext-dev openssl-dev zlib-dev autoconf git bash curl jq
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_VERSION} https://github.com/git/git.git
RUN cd /git && export NO_PERL=1 NO_TCLTK=1 && make configure && ./configure --prefix=/usr/local && make all && rm -rf /usr/local/* && make install

FROM alpine:latest
COPY --from=git-build /usr/local/ /usr/local/
