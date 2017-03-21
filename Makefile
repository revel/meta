
run: deps
	go env
	go run *.go

deps:
	go get -u gopkg.in/yaml.v2
	go get -u github.com/shawncatz/go-github/github
	# TODO: change to 'go get github.com/google/go-github/github' after PR merged

.PHONY: run deps
