base_build:
	@echo "Building base.."
	cd base; docker build -t michaelhenkel/debianbuilder:base .
base_push: base_build
	@echo "Pushing base.."
	docker push michaelhenkel/debianbuilder:base
tf_build: base_build
	@echo "Building tf.."
	cd tf; docker build -t michaelhenkel/debianbuilder:tf .
tf_push: tf_build
	@echo "Pushing tf.."
	docker push michaelhenkel/debianbuilder:tf
binaries_build: tf_build
	@echo "Building binaries..."
	cd binaries; docker build -t michaelhenkel/debianbuilder:binaries .
binaries_push: binaries_build
	@echo "Pushing binaries..."
	docker push michaelhenkel/debianbuilder:binaries
control_build: binaries_build
	@echo "Building control..."
	docker pull michaelhenkel/contrail-distroless
	cd control; docker build -t michaelhenkel/contrail-control:distroless .
control_push: control_build
	@echo "Pushing control..."
	docker push michaelhenkel/contrail-control:distroless
agent_build: binaries_build
	@echo "Building agent..."
	docker pull michaelhenkel/contrail-distroless
	cd agent; docker build -t michaelhenkel/contrail-agent:distroless .
agent_push: agent_build
	@echo "Pushing agent..."
	docker push michaelhenkel/contrail-agent:distroless
vrouter_build: binaries_build
	@echo "Building vrouter..."
	docker pull michaelhenkel/contrail-distroless
	cd vrouter; docker build -t michaelhenkel/contrail-vrouter:distroless .
vrouter_push: vrouter_build
	@echo "Pushing vrouter..."
	docker push michaelhenkel/contrail-vrouter:distroless
init_build:
	@echo "Building init..."
	cd contrail-init; docker build -t michaelhenkel/contrail-init:distroless .
init_push: init_build
	@echo "Pushing init..."
	docker push michaelhenkel/contrail-init:distroless
push_all: control_push agent_push vrouter_push init_push
