# Release Scripts

`clean.sh`

* cleans up directory (don't think this is necessary anymore)

`common.sh`

* common functions

`changelog.sh`

* generate changelog from `git log`

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

* not written yet.
* should merge to master
* send notifications?
* merge from master -> develop
* close milestone on github?
