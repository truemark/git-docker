ARG OS_VERSION
FROM amazonlinux:$OS_VERSION AS build
ARG GIT_VERSION
RUN yum install -q -y make tar curl-devel expat-devel gettext-devel openssl-devel zlib-devel autoconf gcc gcc-c++ git
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch v${GIT_VERSION} https://github.com/git/git.git
RUN rm -rf /usr/local/* && cd /git && \
    export NO_PERL=1 NO_TCLTK=1 NO_EXPAT=1 NO_GETTEXT=1 NO_OPENSSL=1 NO_PYTHON=1 && \
    make configure && ./configure --prefix=/usr/local && \
    make all && \
    make install INSTALL_STRIP="-s"

FROM amazonlinux:$OS_VERSION as test
COPY --from=build /usr/local/ /usr/local/
COPY test.sh /test.sh
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/ /usr/local/
