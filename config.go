package main

import (
	"fmt"
	"io/ioutil"

	"gopkg.in/yaml.v2"
)

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

// Config contains the data in config.yml
type Config struct {
	Repos      []string
	Milestones []Milestone
	Labels     []Label
	Project    struct {
		Columns []string
	}
}

// Milestone contains the milestones from config.yml
type Milestone struct {
	Date    string
	Version string
}

// Label contains the labels from config.yml
type Label struct {
	Name  string
	Color string
}

// Milestone finds the milestone with the given name from the config
func (c *Config) Milestone(name string) bool {
	for _, m := range c.Milestones {
		if m.Version == name {
			return true
		}
	}

	return false
}
