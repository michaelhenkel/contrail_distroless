package(default_visibility = ["//visibility:public"])

load("//base:distro.bzl", "DISTRO_PACKAGES", "DISTRO_SUFFIXES")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("//:checksums.bzl", ARCHITECTURES = "BASE_ARCHITECTURES")

# An image for Contrail
container_image(
    name = "debug_root_amd64_debian10",
    architecture = "amd64",
    base = "//base:debug_root_amd64_debian10",
    debs = [
        #DISTRO_PACKAGES["amd64"]["_debian10"]["iproute2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libselinux1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libmnl0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libelf1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libdb5.3"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libcap2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libpcre3"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["zlib1g"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["lib32z1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libgoogle-perftools4"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["liblzma5"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libstdc++6"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libtcmalloc-minimal4"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libunwind8"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libxml2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libcurl4"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libtbb2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libgcc1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libidn11"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libssh2-1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libnss3"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libnspr4"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libgssapi-krb5-2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libkrb5-3"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libk5crypto3"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libcomerr2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libldap-2.4-2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libkrb5support0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libkeyutils1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-filesystem1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-program-options1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-regex1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-system1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-thread1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libboost-chrono1.67.0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["liblog4cplus-1.1-9"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["librtmp1"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libgmp10"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libgnutls30"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libidn2-0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libp11-kit0"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libtasn1-6"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libunistring2"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libpsl5"],
        #DISTRO_PACKAGES["amd64"]["_debian10"]["libicu63"],
    ],
)

load("@io_bazel_rules_docker//container:container.bzl", "container_bundle")

container_bundle(
	name = "contrailcontrol",
	images = {
		"docker.io/michaelhenkel/contrail-control-distroless": "//control:debug_root_amd64_debian10",
	},
)

load("@io_bazel_rules_docker//contrib:push-all.bzl", "container_push")

container_push(
	name = "publish",
	bundle = ":contrailcontrol",
	format = "Docker",
)
