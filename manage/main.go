package main

import (
	"context"
	"flag"
	"fmt"
	"log"

	"github.com/google/go-github/github"
)

// FILE is the location of the config.yml file
const FILE = "config.yml"

// ORG is the name of the organization
const ORG = "revel"

var (
	ctx    context.Context
	client *github.Client
	config *Config
	git    *Git
	action string
)

func init() {
	flag.Parse()
	action = flag.Arg(0)

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
	switch a := action; a {
	case "releases":
		releases()
	default:
		update()
	}
}

func releases() {
	for _, r := range git.Releases {
		login := ""
		if r.Author != nil {
			login = "@" + *r.Author.Login + " released this "
		}
		fmt.Printf("# %s\n%son %s\n\n%s\n\n", *r.TagName, login, r.CreatedAt.Format("2006-01-02"), *r.Body)
	}
}

func update() {
	// disabling this for now...
	// the GitHub Org Projects do not work very well.
	// using waffle.io instead.
	//
	//for _, m := range config.Milestones {
	//	if m.Version == "Backlog" {
	//		continue
	//	}
	//	p := git.Project(m.Version)
	//	if p == nil {
	//		fmt.Printf("create project on org: %s\n", m.Version)
	//		_, err := createProject(m.Version, "Collect all work for "+m.Version)
	//		if err != nil {
	//			log.Fatalf("error creating project: %s", err)
	//		}
	//	}
	//}

	for _, r := range config.Repos {
		for _, m := range config.Milestones {
			gm := git.Milestone(r, m.Version)
			if gm == nil {
				fmt.Printf("create milestone %s on repo %s\n", m.Version, r)
				_, err := createMilestone(r, m.Version, m.Date)
				if err != nil {
					log.Fatalf("error creating milestone: %s", err)
				}
			}
		}

		for _, l := range config.Labels {
			gl := git.Label(r, l.Name)
			if gl == nil {
				fmt.Printf("create label %s on repo %s\n", l.Name, r)
				_, err := createLabel(r, l.Name, l.Color)
				if err != nil {
					log.Fatalf("error creating label: %s", err)
				}
			}
		}
	}
}
