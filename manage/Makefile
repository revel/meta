BINARY=manage

run: deps build
	./manage

build: $(BINARY)

clean:
	rm -rf $(BINARY)

$(BINARY):
	go build -o $(BINARY)

deps:
	go get -u gopkg.in/yaml.v2
	go get -u github.com/google/go-github/github

.PHONY: run deps clean build
