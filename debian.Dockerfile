ARG OS_VERSION
FROM debian:$OS_VERSION AS build
ARG GIT_VERSION
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -qq git
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch v${GIT_VERSION} https://github.com/git/git.git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq make autoconf gcc zlib1g-dev libcurl4-openssl-dev
RUN cd /git && \
    export NO_PERL=1 NO_TCLTK=1 NO_EXPAT=1 NO_GETTEXT=1 NO_OPENSSL=1 NO_PYTHON=1 DEBIAN_FRONTEND=noninteractive && \
    make configure && ./configure --prefix=/usr/local && \
    make NO_GETTEXT=1 && \
    rm -rf /usr/local/* && \
    make install NO_GETTEXT=1 INSTALL_STRIP="-s"

FROM debian:$OS_VERSION as test
COPY --from=build /usr/local/ /usr/local/
RUN apt-get -qq update && apt-get install -qq libcurl4
COPY test.sh /test.sh
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/ /usr/local/
