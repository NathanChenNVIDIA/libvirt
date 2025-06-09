# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool manifest ci/manifest.yml
#
# https://gitlab.com/libvirt/libvirt-ci

function install_buildenv() {
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get dist-upgrade -y
    apt-get install --no-install-recommends -y \
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
            xsltproc
    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen
    dpkg-reconfigure locales
    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
    export DEBIAN_FRONTEND=noninteractive
    dpkg --add-architecture ppc64el
    apt-get update
    apt-get dist-upgrade -y
    apt-get install --no-install-recommends -y dpkg-dev
    apt-get install --no-install-recommends -y \
            gcc-powerpc64le-linux-gnu \
            libacl1-dev:ppc64el \
            libapparmor-dev:ppc64el \
            libattr1-dev:ppc64el \
            libaudit-dev:ppc64el \
            libblkid-dev:ppc64el \
            libc6-dev:ppc64el \
            libcap-ng-dev:ppc64el \
            libcurl4-gnutls-dev:ppc64el \
            libdevmapper-dev:ppc64el \
            libfuse-dev:ppc64el \
            libglib2.0-dev:ppc64el \
            libglusterfs-dev:ppc64el \
            libgnutls28-dev:ppc64el \
            libiscsi-dev:ppc64el \
            libjson-c-dev:ppc64el \
            libnl-3-dev:ppc64el \
            libnl-route-3-dev:ppc64el \
            libnuma-dev:ppc64el \
            libparted-dev:ppc64el \
            libpcap0.8-dev:ppc64el \
            libpciaccess-dev:ppc64el \
            librbd-dev:ppc64el \
            libreadline-dev:ppc64el \
            libsanlock-dev:ppc64el \
            libsasl2-dev:ppc64el \
            libselinux1-dev:ppc64el \
            libssh-dev:ppc64el \
            libssh2-1-dev:ppc64el \
            libtirpc-dev:ppc64el \
            libudev-dev:ppc64el \
            libxml2-dev:ppc64el \
            systemtap-sdt-dev:ppc64el
    mkdir -p /usr/local/share/meson/cross
    printf "[binaries]\n\
c = '/usr/bin/powerpc64le-linux-gnu-gcc'\n\
ar = '/usr/bin/powerpc64le-linux-gnu-gcc-ar'\n\
strip = '/usr/bin/powerpc64le-linux-gnu-strip'\n\
pkgconfig = '/usr/bin/powerpc64le-linux-gnu-pkg-config'\n\
\n\
[host_machine]\n\
system = 'linux'\n\
cpu_family = 'ppc64'\n\
cpu = 'powerpc64le'\n\
endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu
    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
    mkdir -p /usr/libexec/ccache-wrappers
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-cc
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-gcc
}

export CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
export LANG="en_US.UTF-8"
export MAKE="/usr/bin/make"
export NINJA="/usr/bin/ninja"
export PYTHON="/usr/bin/python3"

export ABI="powerpc64le-linux-gnu"
export MESON_OPTS="--cross-file=powerpc64le-linux-gnu"
