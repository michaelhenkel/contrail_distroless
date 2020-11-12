FROM michaelhenkel/contrail-distroless
RUN ["/busybox/sh", "-c", "mkdir -p /var/log/contrail"]
COPY --from=michaelhenkel/debianbuilder:binaries /contrail-control /contrail-control
COPY --from=michaelhenkel/debianbuilder:binaries /third_party_libs.tgz /third_party_libs.tgz
RUN ["/busybox/sh", "-c", "tar zxf /third_party_libs.tgz"]
