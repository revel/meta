package main

// go get gopkg.in/yaml.v2
// go get github.com/shawncatz/go-github/github
// TODO: change to 'go get github.com/google/go-github/github' after PR merged

import (
	"context"
	"fmt"
	"log"

	"github.com/shawncatz/go-github/github"
)

const FILE = "config.yml"

var (
	ctx    context.Context
	client *github.Client
	config *Config
	git    *Git
)

func init() {
	if err := loadConfig(); err != nil {
		log.Fatalf("error loading config: %s", err)
	}

	if err := loadGithub(); err != nil {
		log.Fatalf("error loading github: %s", err)
	}
}

func main() {
	//fmt.Printf("config: %#v\n", config)
	//fmt.Printf(git.String())

	for _, m := range config.Milestones {
		if m.Version == "Backlog" {
			continue
		}
		p := git.Project(m.Version)
		if p == nil {
			fmt.Printf("create project on org: %s\n", m.Version)
		}
	}

	for _, r := range config.Repos {
		for _, m := range config.Milestones {
			gm := git.Milestone(r, m.Version)
			if gm == nil {
				fmt.Printf("create milestone %s on repo %s\n", m.Version, r)
			}
		}

		for _, l := range config.Labels {
			gl := git.Label(r, l.Name)
			if gl == nil {
				fmt.Printf("create label %s on repo %s\n", l.Name, r)
			}
		}
	}
}
