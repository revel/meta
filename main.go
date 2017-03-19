package main

// go get gopkg.in/yaml.v2
// go get github.com/shawncatz/go-github/github
// TODO: change to 'go get github.com/google/go-github/github' after PR merged

import (
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"

	// TODO: change this once PR is merged: https://github.com/google/go-github/pull/599
	"github.com/shawncatz/go-github/github"
	"gopkg.in/yaml.v2"
)

const FILE = "config.yml"

var (
	ctx    context.Context
	client *github.Client
	config *Config
	git    *Git
)

type Config struct {
	Repos      []string
	Milestones []Milestone
	Labels     []Label
}

type Milestone struct {
	Date    string
	Version string
}

type Label struct {
	Name  string
	Color string
}

func (c *Config) Milestone(name string) bool {
	for _, m := range c.Milestones {
		if m.Version == name {
			return true
		}
	}

	return false
}

type Git struct {
	// list of organization projects
	Projects []*github.Project
	// map of repo name to repo object
	Repos map[string]GitRepo
}

type GitRepo struct {
	Milestones []*github.Milestone
	Labels     []*github.Label
}

func (g *Git) Project(name string) *github.Project {
	for _, p := range g.Projects {
		if *p.Name == name {
			return p
		}
	}

	return nil
}

func (g *Git) Milestone(repo, name string) *github.Milestone {
	for _, m := range g.Repos[repo].Milestones {
		if *m.Title == name {
			return m
		}
	}

	return nil
}

func (g *Git) Label(repo, name string) *github.Label {
	for _, m := range g.Repos[repo].Labels {
		if *m.Name == name {
			return m
		}
	}

	return nil
}

func (g *Git) String() string {
	s := ""

	s += "Projects:\n"
	for _, p := range g.Projects {
		s += fmt.Sprintf("  %d '%s'\n", p.ID, *p.Name)
	}

	s += "Repos:\n"
	for _, r := range config.Repos {
		s += "  " + r + "\n"
		s += "    milestones:\n"
		for _, m := range g.Repos[r].Milestones {
			s += "      " + *m.Title
			if m.DueOn != nil {
				s += " " + m.DueOn.String()
			}
			s += "\n"
		}
		s += "    labels:\n"
		for _, l := range g.Repos[r].Labels {
			s += "      " + *l.Name + " " + *l.Color + "\n"
		}
	}

	return s
}

func init() {
	if err := loadConfig(); err != nil {
		log.Fatalf("error loading config: %s", err)
	}

	if err := loadGithub(); err != nil {
		log.Fatalf("error loading github: %s", err)
	}
}

func loadGithub() error {
	username := "shawncatz"
	password := os.Getenv("GITHUB_TOKEN")

	tp := github.BasicAuthTransport{
		Username: strings.TrimSpace(username),
		Password: strings.TrimSpace(password),
	}

	client = github.NewClient(tp.Client())
	ctx = context.Background()

	git = &Git{Repos: make(map[string]GitRepo)}

	projects, _, err := client.Organizations.ListProjects(ctx, "revel", &github.ListProjectsOptions{})
	if err != nil {
		return err
	}

	git.Projects = projects

	for _, r := range config.Repos {
		list, _, err := client.Issues.ListMilestones(ctx, "revel", r, &github.MilestoneListOptions{})
		if err != nil {
			return err
		}

		gr := GitRepo{}

		gr.Milestones = list

		labels, _, err := client.Issues.ListLabels(ctx, "revel", r, &github.ListOptions{})
		if err != nil {
			return err
		}

		gr.Labels = labels

		git.Repos[r] = gr
	}

	return nil
}

func loadConfig() error {
	config = &Config{}
	var err error
	var data []byte

	data, err = ioutil.ReadFile(FILE)
	if err != nil {
		return fmt.Errorf("error reading file: %s", err)
	}

	err = yaml.Unmarshal([]byte(data), &config)
	if err != nil {
		return fmt.Errorf("error unmarshaling yaml: %v", err)
	}

	return nil
}

//func listProjects() ([]*github.Project, error) {
//	projects, _, err := client.Organizations.ListProjects(ctx, "revel", &github.ListProjectsOptions{})
//	if err != nil {
//		return nil, err
//	}
//
//	//for _, p := range projects {
//	//  fmt.Printf("%d %s\n", p.ID, *p.Name)
//	//}
//
//	return projects, nil
//}
//
//func listMilestones(repo string) ([]*github.Milestone, error) {
//	list, _, err := client.Issues.ListMilestones(ctx, "revel", repo, &github.MilestoneListOptions{})
//	if err != nil {
//		return nil, err
//	}
//
//	return list, nil
//}

func main() {
	//fmt.Printf("config: %#v\n", config)
	fmt.Printf(git.String())

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
