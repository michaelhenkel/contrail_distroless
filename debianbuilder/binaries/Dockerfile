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
#RUN make -j$(grep -c ^processor KERNELDIR=/usr/src/kernels/3.10.0-1127.19.1.el7.x86_64 SANDESH_HEADER_PATH=/tf-dev-env/build/debug/vrouter SANDESH_SRC_ROOT=../build/kbuild/ SANDESH_EXTRA_HEADER_PATH=/tf-dev-env/src/contrail-common
