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
        DISTRO_PACKAGES["amd64"]["_debian10"]["iproute2"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libselinux1"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libmnl0"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libelf1"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libdb5.3"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libcap2"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["libpcre3"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["zlib1g"],
        DISTRO_PACKAGES["amd64"]["_debian10"]["lib32z1"],
    ],
)

load("@io_bazel_rules_docker//container:container.bzl", "container_bundle")

container_bundle(
	name = "contrail",
	images = {
		"docker.io/michaelhenkel/contrail-distroless": "//contrail:debug_root_amd64_debian10",
	},
)

load("@io_bazel_rules_docker//contrib:push-all.bzl", "container_push")

container_push(
	name = "publish",
	bundle = ":contrail",
	format = "Docker",
)
