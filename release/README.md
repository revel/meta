# Release Scripts

## Scripts

`common.sh`

* common functions

`configure.sh`

* configuration

`changelog.sh`

* generate changelog from `git log`
* this should be changed to be smarter

`prepare.sh`

* create an entirely new checkout of all of the code
* makes sure develop is up to date with master
* creates release/version branch
* updates version, date, minimum go in version.go and README.md
* builds revel from release branches

`test.sh`

* executes tests against repos that have tests
* executes examples tests against booking and chat

`release.sh`

* should merge to master
* send notifications?
* merge from master -> develop
* close milestone on github?

## Process

#### ./configure.sh  \<version\> \<min golang version\>

* creates configuration file

#### ./prepare.sh

* checkout everything into a tmp working directory
* ensure that develop is up to date with master (git merge master)
* create the release branch from develop
* update the `revel/revel` changelog, readme, and version.go
* update the `revel/revel.github.io` version

#### edit

* make updates to the repos
* this is our chance to make any final changes before it goes to master
* manually tweak the changelog
* add any README updates

#### ./test.sh

* execute `go test` on `revel`, `cmd/revel`, `config`, `cron`
* execute `revel test` on `examples/booking` and `examples/chat`
* verify that everything passed (the script will fail if any exit non-zero)
    

#### ./release.sh \<next version\>

* commit changes on `revel/revel`, `revel/revel.github.io`
* create release tag (on all repos)
* (?) add changelog notes to releases page (not sure if I can do this automatically)
* merge release branch to master
* merge master branch to develop
* update version in develop to next version
    * release: v0.15.0
    * next version: v0.16.0-dev
* commit new version to develop

#### ./changelog.sh > changes.md

* Echo commit messages to the changes.md


#### ./push.sh

* push all of the commits, branches, tags
* makes the release LIVE
   

#### notify?

* send notifications
* Massage changes.md and distribute to google groups and others

#### ./godeps.sh
* Generate the \<version\>.godeps file for all packages

#### Final Steps
* Test in new folder 
  * mkdir test
  * export GOPATH=$PWD
  * gdm restore -f \<version\>.godeps
  * go build github.com/revel/cmd/revel
  *  ./revel version
DEBUG 07:02:47  revel  server.go:27: RegisterServerEngine: Registered engine   section=server name=go 
~
~ revel! http://revel.github.io
~
Version(s):
   Revel v0.18-dev (2017-07-14)
   go1.8.3 linux/amd64

* Commit and push the godeps file

## RC Process

#### ./configure.sh  \<version\> \<min golang version\>

* creates configuration file

#### ./prepare-1-clone.sh

* Clones all repos

#### ./test.sh

* execute `go test` on `revel`, `cmd/revel`, `config`, `cron`
* execute `revel test` on `examples/booking` and `examples/chat`
* verify that everything passed (the script will fail if any exit non-zero)

#### ./godeps.sh
* Generate the \<version\>.godeps file for all packages

#### Final Steps
* Test in new folder 
  * mkdir test
  * export GOPATH=$PWD
  * gdm restore -f \<version\>.godeps
  * go build github.com/revel/cmd/revel
  *  ./revel version
DEBUG 07:02:47  revel  server.go:27: RegisterServerEngine: Registered engine   section=server name=go 
~
~ revel! http://revel.github.io
~
Version(s):
   Revel v0.18-dev (2017-07-14)
   go1.8.3 linux/amd64
* Commit and push the godeps file
