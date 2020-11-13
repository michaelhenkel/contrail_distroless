FROM michaelhenkel/contrail-distroless
COPY init_kmod.sh init_kmod.sh
COPY --from=michaelhenkel/debianbuilder:binaries /kernelmodules /kernelmodules
COPY --from=michaelhenkel/debianbuilder:binaries /tf-dev-env/build/production/vrouter/utils/vif /vif
