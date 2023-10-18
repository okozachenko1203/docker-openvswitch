FROM quay.io/centos/centos:stream9
ARG OVS_SERIES
ARG OVS_VERSION
RUN \
  dnf -y install centos-release-nfv-openvswitch.noarch && \
  dnf -y install openvswitch${OVS_SERIES}-${OVS_VERSION}.el9s iptables \
    --installroot /build \
    --releasever 9-stream \
    --setopt=install_weak_deps=False \
    --setopt=tsflags=nodocs \
    --setopt=override_install_langs=en_US.utf8 && \
  dnf -y clean all \
    --installroot /build \
    --releasever 9-stream && \
  rm -rf /build/var/cache/dnf

FROM scratch
COPY --from=0 /build /
