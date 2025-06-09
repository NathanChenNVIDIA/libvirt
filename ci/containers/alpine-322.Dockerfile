# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool manifest ci/manifest.yml
#
# https://gitlab.com/libvirt/libvirt-ci

FROM docker.io/library/alpine:3.22

RUN apk update && \
    apk upgrade && \
    apk add \
        acl-dev \
        attr-dev \
        audit-dev \
        augeas \
        bash-completion \
        black \
        ca-certificates \
        ccache \
        ceph-dev \
        clang \
        curl-dev \
        cyrus-sasl-dev \
        diffutils \
        eudev-dev \
        fuse-dev \
        gcc \
        gettext \
        git \
        glib-dev \
        gnutls-dev \
        grep \
        iptables \
        json-c-dev \
        libcap-ng-dev \
        libnl3-dev \
        libpcap-dev \
        libpciaccess-dev \
        libselinux-dev \
        libssh-dev \
        libssh2-dev \
        libtirpc-dev \
        libxml2-dev \
        libxml2-utils \
        libxslt \
        lvm2-dev \
        make \
        meson \
        musl-dev \
        netcf-dev \
        numactl-dev \
        parted-dev \
        perl \
        pkgconf \
        py3-docutils \
        py3-flake8 \
        py3-pytest \
        python3 \
        qemu-img \
        readline-dev \
        samurai \
        sed \
        util-linux-dev \
        wireshark-dev \
        xen-dev && \
    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
    apk list --installed | sort > /packages.txt && \
    mkdir -p /usr/libexec/ccache-wrappers && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc

ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
ENV LANG "en_US.UTF-8"
ENV MAKE "/usr/bin/make"
ENV NINJA "/usr/bin/ninja"
ENV PYTHON "/usr/bin/python3"
