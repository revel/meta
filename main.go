package main

import (
	"context"
	"fmt"
	"log"

	"github.com/shawncatz/go-github/github"
)

const FILE = "config.yml"
const ORG = "revel"

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
			_, err := CreateProject(m.Version, "Collect all work for "+m.Version)
			if err != nil {
				log.Fatalf("error creating project: %s", err)
			}
		}
	}

	for _, r := range config.Repos {
		for _, m := range config.Milestones {
			gm := git.Milestone(r, m.Version)
			if gm == nil {
				fmt.Printf("create milestone %s on repo %s\n", m.Version, r)
				_, err := CreateMilestone(r, m.Version, m.Date)
				if err != nil {
					log.Fatalf("error creating milestone: %s", err)
				}
			}
		}

		for _, l := range config.Labels {
			gl := git.Label(r, l.Name)
			if gl == nil {
				fmt.Printf("create label %s on repo %s\n", l.Name, r)
				_, err := CreateLabel(r, l.Name, l.Color)
				if err != nil {
					log.Fatalf("error creating label: %s", err)
				}
			}
		}
	}
}
