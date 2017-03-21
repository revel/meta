
run: deps
	go run *.go

deps:
	go get gopkg.in/yaml.v2
	go get github.com/shawncatz/go-github/github
	# TODO: change to 'go get github.com/google/go-github/github' after PR merged

.PHONY: run deps
