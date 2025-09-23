# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool manifest ci/manifest.yml
#
# https://gitlab.com/libvirt/libvirt-ci

FROM docker.io/library/debian:12-slim

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
    dpkg --add-architecture mipsel && \
    eatmydata apt-get update && \
    eatmydata apt-get dist-upgrade -y && \
    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
    eatmydata apt-get install --no-install-recommends -y \
                      gcc-mipsel-linux-gnu \
                      libacl1-dev:mipsel \
                      libapparmor-dev:mipsel \
                      libattr1-dev:mipsel \
                      libaudit-dev:mipsel \
                      libblkid-dev:mipsel \
                      libc6-dev:mipsel \
                      libcap-ng-dev:mipsel \
                      libcurl4-gnutls-dev:mipsel \
                      libdevmapper-dev:mipsel \
                      libfuse-dev:mipsel \
                      libglib2.0-dev:mipsel \
                      libglusterfs-dev:mipsel \
                      libgnutls28-dev:mipsel \
                      libiscsi-dev:mipsel \
                      libjson-c-dev:mipsel \
                      libnl-3-dev:mipsel \
                      libnl-route-3-dev:mipsel \
                      libnuma-dev:mipsel \
                      libparted-dev:mipsel \
                      libpcap0.8-dev:mipsel \
                      libpciaccess-dev:mipsel \
                      librbd-dev:mipsel \
                      libreadline-dev:mipsel \
                      libsanlock-dev:mipsel \
                      libsasl2-dev:mipsel \
                      libselinux1-dev:mipsel \
                      libssh-dev:mipsel \
                      libssh2-1-dev:mipsel \
                      libtirpc-dev:mipsel \
                      libudev-dev:mipsel \
                      libxml2-dev:mipsel \
                      systemtap-sdt-dev:mipsel && \
    eatmydata apt-get autoremove -y && \
    eatmydata apt-get autoclean -y && \
    mkdir -p /usr/local/share/meson/cross && \
    printf "[binaries]\n\
c = '/usr/bin/mipsel-linux-gnu-gcc'\n\
ar = '/usr/bin/mipsel-linux-gnu-gcc-ar'\n\
strip = '/usr/bin/mipsel-linux-gnu-strip'\n\
pkgconfig = '/usr/bin/mipsel-linux-gnu-pkg-config'\n\
\n\
[host_machine]\n\
system = 'linux'\n\
cpu_family = 'mips'\n\
cpu = 'mipsel'\n\
endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
    mkdir -p /usr/libexec/ccache-wrappers && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc

ENV ABI="mipsel-linux-gnu"
ENV MESON_OPTS="--cross-file=mipsel-linux-gnu"
