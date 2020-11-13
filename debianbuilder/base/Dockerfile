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
    libbz2-dev \
    libvirt-dev \
    libnuma-dev \
    rpm2cpio \
    jq \
    libpcap-dev \
    libxml2-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    cpio
RUN rm //usr/bin/g++ /usr/bin/cpp /usr/bin/gcc && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
    update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-4.9 10 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10
#RUN ln -s /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/x86_64-linux-gnu/libxml2.so && \
RUN ln -s /usr/lib/libtcmalloc_minimal.so.4.3.0 /usr/lib/libtcmalloc.so
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
    cp build/libcassandra.so* /libs/usr/lib/x86_64-linux-gnu
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
