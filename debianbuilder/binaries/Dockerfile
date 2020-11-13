FROM michaelhenkel/debianbuilder:tf
SHELL ["/bin/bash", "-c"]
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) control-node && \
    cp build/production/control-node/contrail-control /
RUN strip /contrail-control
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) contrail-vrouter-agent && \
    cp build/production/vnsw/agent/contrail/contrail-vrouter-agent /
RUN strip /contrail-vrouter-agent
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) vrouter/utils && \
    cp build/production/vrouter/utils/vif /
RUN strip /vif
COPY kernellist.json /
COPY getKernelSources.sh /
RUN /getKernelSources.sh
RUN cd tf-dev-env && \
    for KERNELDIR in $(cat /kernellist); do scons --kernel-dir=${KERNELDIR} --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) vrouter/vrouter.ko; mkdir -p /kernelmodules/$(basename ${KERNELDIR}); cp vrouter/vrouter.ko /kernelmodules/$(basename ${KERNELDIR}); done
