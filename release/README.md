# Release Scripts

## Scripts

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

## Process

    # prepare.sh \<version\> \<min golang version\>
    prepare.sh 0.15.0 1.7

* checkout everything into a tmp working directory
* ensure that develop is up to date with master (git merge master)
* create the release branch from develop
* update the `revel/revel` changelog, readme, and version.go
* update the `revel/revel.github.io` version

* make updates to the repos
    * this is our chance to make any final changes before it goes to master
    * manually tweak the changelog
    * add any README updates

* run `test.sh`, this will:
    * execute `go test` on `revel`, `cmd/revel`, `config`, `cron`
    * execute `revel test` on `examples/booking` and `examples/chat`
    * verify that everything passed (the script will fail if any exit non-zero)
    
* run `release.sh`, this will:
    * commit changes on `revel/revel`, `revel/revel.github.io`
    * create release tag (on all repos)
    * (?) add changelog notes to releases page (not sure if I can do this automatically)
    * merge release branch to master
    * merge master branch to develop
    * update version in develop to next version
        * release: v0.15.0
        * next version: v0.16.0-dev
    * commit new version to develop
    
* run `push.sh`, this will:
    * push all of the commits, branches, tags
    * makes the release LIVE
    
* `notify.sh` ?  
    * send notifications? (not sure how / where... will probably need something other than bash script)

