FROM amazonlinux:2 AS git-build
ARG GIT_VERSION
ARG GIT_CRYPT_VERSION
RUN yum install -q -y make tar curl-devel expat-devel gettext-devel openssl-devel zlib-devel autoconf gcc gcc-c++
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_VERSION} https://github.com/git/git.git
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN cd /git && export NO_PERL=1 NO_TCLTK=1 && make configure && ./configure --prefix=/usr/local && make all && make install
RUN cd /git-crypt && make && make install

FROM amazonlinux:2
COPY --from=git-build /usr/local/ /usr/local/
