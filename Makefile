dependency:
	go mod tidy

test: dependency
	go test ./...

linux_build: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/main
	-cp -r ./conf ./out/conf

build: dependency
	CGO_ENABLED=0 go build -a -installsuffix cgo -o ./out/main
	-cp -r ./conf ./out/conf

build-server: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/wsserver ./server/
	-cp -r ./conf ./out/conf

build-client: dependency
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./out/wsclient ./client/
	-cp -r ./conf ./out/conf
clean:
	-rm -r ./out
