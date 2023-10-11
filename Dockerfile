ARG OVS_SERIES
ARG OVS_VERSION

FROM quay.io/centos/centos:stream9
RUN --mount=type=cache,target=/var/cache/dnf \
  dnf -y install centos-release-nfv-openvswitch.noarch && \
  dnf -y install openvswitch${OVS_SERIES}-${OVS_VERSION}.el9s \
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
