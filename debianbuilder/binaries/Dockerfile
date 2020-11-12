FROM michaelhenkel/debianbuilder:tf
SHELL ["/bin/bash", "-c"]
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) control-node && \
    cp build/production/control-node/contrail-control /
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) contrail-vrouter-agent && \
    cp build/production/vnsw/agent/contrail/contrail-vrouter-agent /
RUN strip /contrail-vrouter-agent
