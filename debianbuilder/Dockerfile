FROM debian:oldstable AS builder
SHELL ["/bin/bash", "-c"]
RUN echo "deb http://deb.debian.org/debian oldoldstable main" >> /etc/apt/sources.list
RUN apt update -y && \
    apt install -y git \
    curl \
    python \
    python3 \
    scons \
    autoconf \
    bzip2 \
    libtool \
    libtool-bin \
    unzip \
    python-pip \
    python-yaml \
    flex \
    bison \
    python-lxml \
    libssl1.0-dev \
    cmake \
    libcurl4-gnutls-dev \
    g++-4.9 \
    libuv1-dev \
    zlib1g-dev \
    libtcmalloc-minimal4 \
    xxd \
    libbz2-dev
RUN rm //usr/bin/g++ /usr/bin/cpp /usr/bin/gcc && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
    update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-4.9 10 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10
RUN ln -s /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/x86_64-linux-gnu/libxml2.so && \
    ln -s /usr/lib/libtcmalloc_minimal.so.4.3.0 /usr/lib/libtcmalloc.so
RUN pip install future
RUN mkdir -p /libs/usr/lib/x86_64-linux-gnu
RUN git clone https://github.com/datastax/cpp-driver && \
    cd cpp-driver/ && \
    git checkout tags/2.7.0 && \
    mkdir build && \
    pushd build && \
    cmake .. && \
    make -j$(grep -c ^processor /proc/cpuinfo) && \
    make install && \
    popd && \
    cd /
RUN curl -OL http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz && \
    tar zxvf boost_1_55_0.tar.gz && \
    cd boost_1_55_0 && \
    ./bootstrap.sh --libdir=/usr/lib/x86_64-linux-gnu --includedir=/usr/include && \
    ./b2 -j$(grep -c ^processor /proc/cpuinfo) --libdir=/usr/lib/x86_64-linux-gnu --includedir=/usr/include install && \
    cp ./bin.v2/libs/regex/build/gcc-4.9.2/release/threading-multi/libboost_regex.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu && \
    cp ./bin.v2/libs/chrono/build/gcc-4.9.2/release/threading-multi/libboost_chrono.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu && \
    cp ./bin.v2/libs/program_options/build/gcc-4.9.2/release/threading-multi/libboost_program_options.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu && \
    cp ./bin.v2/libs/filesystem/build/gcc-4.9.2/release/threading-multi/libboost_filesystem.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu && \
    cp ./bin.v2/libs/system/build/gcc-4.9.2/release/threading-multi/libboost_system.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu && \
    cp ./bin.v2/libs/thread/build/gcc-4.9.2/release/threading-multi/libboost_thread.so.1.55.0 /libs/usr/lib/x86_64-linux-gnu
COPY boost.patch /
RUN cat boost.patch |patch -p0
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && \
    chmod +x /bin/repo
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
RUN cd /libs && \
    tar czvf third_party_libs.tgz usr && \
    cp third_party_libs.tgz /
RUN cd tf-dev-env && \
    scons --c++=c++11 --opt=production -j$(grep -c ^processor /proc/cpuinfo) control-node && \
    cp build/production/control-node/contrail-control / && \
    strip contrail-control
