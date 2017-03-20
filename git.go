package main

import (
	"context"
	"fmt"
	"os"

	"github.com/shawncatz/go-github/github"
)

func loadGithub() error {
	username := "shawncatz"
	password := os.Getenv("GITHUB_TOKEN")

	tp := github.BasicAuthTransport{
		Username: username,
		Password: password,
	}

	client = github.NewClient(tp.Client())
	ctx = context.Background()

	git = &Git{Repos: make(map[string]GitRepo)}

	projects, _, err := client.Organizations.ListProjects(ctx, "revel", &github.ProjectListOptions{})
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

		labels, err := getLabels(r)
		if err != nil {
			return err
		}

		gr.Labels = labels

		git.Repos[r] = gr
	}

	return nil
}

// getLabels returns a combined slice of labels from paged responses
// some repos might have more labels than fit in a single page
func getLabels(repo string) ([]*github.Label, error) {
	out := []*github.Label{}
	page := 1
	lastpage := 0

	for ok := true; ok; ok = (page == lastpage) {
		labels, resp, err := client.Issues.ListLabels(ctx, "revel", repo, &github.ListOptions{Page: page})
		if err != nil {
			return nil, err
		}

		out = append(out, labels...) // ... breaks the slice into variadic parameters
		lastpage = resp.LastPage
		page++
	}

	return out, nil
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
