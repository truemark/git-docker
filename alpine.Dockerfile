ARG OS_VERSION
FROM alpine:$OS_VERSION AS build
ARG GIT_VERSION
RUN apk update && apk add --no-cache git
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch v${GIT_VERSION} https://github.com/git/git.git
RUN apk add --no-cache git make autoconf g++ zlib-dev curl-dev
RUN cd /git && \
    export NO_PERL=1 NO_TCLTK=1 NO_EXPAT=1 NO_GETTEXT=1 NO_OPENSSL=1 NO_PYTHON=1 && \
    make configure && ./configure --prefix=/usr/local && \
    make && \
    rm -rf /usr/local/* && \
    make install INSTALL_STRIP="-s"

FROM alpine:$OS_VERSION as test
RUN apk add --no-cache bash libcurl
COPY --from=build /usr/local/ /usr/local/
COPY test.sh /test.sh
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/ /usr/local/
