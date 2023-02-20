.PHONY: run-dev-container dev-container prod-container clean

run-dev-container: dev-container
	docker run \
	-v $(shell pwd):/workspace \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube:/home/user/.kube \
	--net host \
	-it devcontainer

dev-container:
	docker build \
	-t devcontainer \
	-f devcontainer.Dockerfile \
	--build-arg DOCKER_GROUP_GID=${shell getent group docker | cut -d: -f3} \
	.

kind:
	kind create cluster --name products

api:
	can --configFile openapi/can.yaml
	go mod tidy
	go fmt ./...

dist: api
	mkdir -p dist
	CGO_ENABLED=0 go build -o ./dist ./cmd/...

prod-container: dist
	docker build -t products -f prod.Dockerfile .

run-prod-container: prod-container
	docker run -p 8080:8080 -it products

kind-upload-prod-container:
	kind load --name products docker-image products

kind-deploy:
	kubectl apply -f k8s/products.yaml

clean:
	rm -fr dist api
