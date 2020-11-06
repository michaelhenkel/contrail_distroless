FROM docker.io/michaelhenkel/contrail-distroless
COPY init_kmod.sh init_kmod.sh
COPY vif vif
COPY 3.10.0-1127.19.1.el7.x86_64 3.10.0-1127.19.1.el7.x86_64
ENTRYPOINT ["/bin/sh", "/init_kmod.sh"]
