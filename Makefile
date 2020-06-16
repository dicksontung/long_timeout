.DEFAULT_GOAL := all

dependency:
	go mod tidy

test: dependency
	go test ./...

linux_build: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/main
	-cp -r ./conf ./out/conf

build-server: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/server ./server/
	-cp -r ./conf ./out/conf

build-client: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/client ./client/
	-cp -r ./conf ./out/conf

clean:
	-rm -r ./out

all: clean build-server build-client

docker-server:
	docker build -f ws_server.Dockerfile . --tag dixont/ws_server

docker-client:
	docker build -f ws_client.Dockerfile . --tag dixont/ws_client

docker-all: all docker-server docker-client
