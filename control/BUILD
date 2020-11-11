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
        DISTRO_PACKAGES["amd64"]["_debian10"]["libstdc++6"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libunwind8"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["ca-certificates"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["openssl"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libcurl4"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libcom-err2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libgssapi-krb5-2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libk5crypto3"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libkeyutils1"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libkrb5support0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libkrb5-3"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libssl1.1"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libpcre3"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libbz2-1.0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["liblzma5"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["zlib1g"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libidn2-0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libunistring2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libldap-2.4-2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libgnutls30"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libgmp10"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libhogweed4"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libnettle6"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libp11-kit0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libffi6"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libtasn1-6"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libsasl2-2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libsasl2-modules-db"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libdb5.3"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libnghttp2-14"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libpsl5"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["librtmp1"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libssh2-1"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libgcrypt20"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libgpg-error0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libssl1.0.0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libcurl3-gnutls"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libcomerr2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libicu57"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libidn11"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libssl1.0.2"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libunistring0"],
	DISTRO_PACKAGES["amd64"]["_debian10"]["libxml2"],
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
