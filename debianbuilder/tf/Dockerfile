FROM michaelhenkel/debianbuilder:base
SHELL ["/bin/bash", "-c"]
RUN git clone https://github.com/tungstenfabric/tf-dev-env && \
    cd tf-dev-env && \
    git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    repo init -u https://github.com/edwinpjacques/tf-vnc -q && \
    repo sync -q
RUN cd tf-dev-env/third_party && \
    ./fetch_packages.py || true
RUN  cd tf-dev-env/third_party/log4cplus-1.1.1 && \
    ./configure --libdir /usr/lib/x86_64-linux-gnu/ --includedir /usr/include CXXFLAGS="-std=c++11" && \
    make -j$(grep -c ^processor /proc/cpuinfo) && \
    make install && \
    cp src/.libs/liblog4cplus*so* /usr/lib/x86_64-linux-gnu && \
    cp src/.libs/liblog4cplus*so* /libs/usr/lib/x86_64-linux-gnu
RUN cd tf-dev-env/third_party/tbb-2018_U5 && \
    make -j$(grep -c ^processor /proc/cpuinfo) && \
    cp ./build/linux_intel64_gcc_cc4.9.2_libc2.24_kernel4.19.104_release/*.so* /usr/lib/x86_64-linux-gnu && \
    cp ./build/linux_intel64_gcc_cc4.9.2_libc2.24_kernel4.19.104_release/*.so* /libs/usr/lib/x86_64-linux-gnu
COPY control.patch /
RUN cat control.patch |patch -p0
COPY agent.patch /
RUN cat agent.patch |patch -p0
RUN cd /libs && \
    tar czvf third_party_libs.tgz usr && \
    cp third_party_libs.tgz /
