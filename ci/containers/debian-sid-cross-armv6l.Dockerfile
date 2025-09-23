# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool manifest ci/manifest.yml
#
# https://gitlab.com/libvirt/libvirt-ci

FROM docker.io/library/debian:sid-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y eatmydata && \
    eatmydata apt-get dist-upgrade -y && \
    eatmydata apt-get install --no-install-recommends -y \
                      augeas-lenses \
                      augeas-tools \
                      bash-completion \
                      black \
                      ca-certificates \
                      ccache \
                      codespell \
                      cpp \
                      diffutils \
                      dwarves \
                      ebtables \
                      flake8 \
                      gettext \
                      git \
                      grep \
                      libclang-rt-dev \
                      libnbd-dev \
                      libxml2-utils \
                      locales \
                      make \
                      meson \
                      ninja-build \
                      perl-base \
                      pkgconf \
                      python3 \
                      python3-docutils \
                      python3-pytest \
                      qemu-utils \
                      sed \
                      xsltproc && \
    eatmydata apt-get autoremove -y && \
    eatmydata apt-get autoclean -y && \
    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
    dpkg-reconfigure locales && \
    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED

ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
ENV LANG="en_US.UTF-8"
ENV MAKE="/usr/bin/make"
ENV NINJA="/usr/bin/ninja"
ENV PYTHON="/usr/bin/python3"

RUN export DEBIAN_FRONTEND=noninteractive && \
    dpkg --add-architecture armel && \
    eatmydata apt-get update && \
    eatmydata apt-get dist-upgrade -y && \
    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
    eatmydata apt-get install --no-install-recommends -y \
                      gcc-arm-linux-gnueabi \
                      libacl1-dev:armel \
                      libapparmor-dev:armel \
                      libattr1-dev:armel \
                      libaudit-dev:armel \
                      libblkid-dev:armel \
                      libc6-dev:armel \
                      libcap-ng-dev:armel \
                      libcurl4-gnutls-dev:armel \
                      libdevmapper-dev:armel \
                      libfuse-dev:armel \
                      libglib2.0-dev:armel \
                      libgnutls28-dev:armel \
                      libiscsi-dev:armel \
                      libjson-c-dev:armel \
                      libnl-3-dev:armel \
                      libnl-route-3-dev:armel \
                      libnuma-dev:armel \
                      libparted-dev:armel \
                      libpcap0.8-dev:armel \
                      libpciaccess-dev:armel \
                      libreadline-dev:armel \
                      libsanlock-dev:armel \
                      libsasl2-dev:armel \
                      libselinux1-dev:armel \
                      libssh-dev:armel \
                      libssh2-1-dev:armel \
                      libtirpc-dev:armel \
                      libudev-dev:armel \
                      libxml2-dev:armel \
                      systemtap-sdt-dev:armel && \
    eatmydata apt-get autoremove -y && \
    eatmydata apt-get autoclean -y && \
    mkdir -p /usr/local/share/meson/cross && \
    printf "[binaries]\n\
c = '/usr/bin/arm-linux-gnueabi-gcc'\n\
ar = '/usr/bin/arm-linux-gnueabi-gcc-ar'\n\
strip = '/usr/bin/arm-linux-gnueabi-strip'\n\
pkgconfig = '/usr/bin/arm-linux-gnueabi-pkg-config'\n\
\n\
[host_machine]\n\
system = 'linux'\n\
cpu_family = 'arm'\n\
cpu = 'arm'\n\
endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
    mkdir -p /usr/libexec/ccache-wrappers && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-cc && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-gcc

ENV ABI="arm-linux-gnueabi"
ENV MESON_OPTS="--cross-file=arm-linux-gnueabi"
