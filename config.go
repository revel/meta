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
