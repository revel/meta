deps
# CHANGELOG

## v1.0.0

[[revel/revel](https://github.com/revel/revel)]

* 3d1b0c3 Merge pull request #1497 from lujiacn/master
* ff2da7e Merge pull request #1498 from aacapella/feature/same-site-cookies
* c6c4c35 SameSite cookie support
* bfad570 Update server_adapter_go.go
* ff43c73 Merge pull request #1491 from notzippy/go-mod
* dbe9fee Update .travis.yml
* 38b0687 Fixed paths for test cases
* 39523bf Enhanced logging
* 59b8375 Changes to Revel for go.mod support Modified module lookup to handle lookups using the app.conf (before relied on source file) Added extra logging for routes error handling
* 1053f49 Merge pull request #1443 from lujiacn/develop
* dcafb9e Merge pull request #1488 from notzippy/go-mod
* e30c8da Merge pull request #1483 from goevexx/feature/fix-issue-1482
* 50e70f9 Updated revel to receive paths passed in Updated watcher to use master branch
* d581f71 change import to fix issue 1482
* fdc724a Merge pull request #1462 from torden/feature/fix_puretextstrict
* fe4861c Fix (#1458) the undetected self-closing tags in isPureTextStrict Fix (#1458) the always uses STRICT mode in PureText.IsSatisFied
* ae3895a added wasm mime-type
* 45ec814 Merge pull request #1439 from mukeshjeengar/hotfix/log-rotation-fixed
* d3a76ed log rotation fixed
* 2eb9067 Merge pull request #1413 from nevkontakte/patch-1
* ccf085e Merge pull request #1434 from dmjones/fix-1433
* 34e886a Don't invoke action when Before returns value
* 5b70626 Merge pull request #1427 from SYM01/hotfix/avoid-dos
* d160ecb fix issue #1424
* db7db5b remove unneccsary code assignment to nil
* 8bff5bb Update controller.go
* 16f5fef Remove a stray println call.
* 60c3d7a develop v1.0.0-dev

[[revel/cmd](https://github.com/revel/cmd)]

* d8117a3 Merge pull request #186 from notzippy/go-mod
* 6371373 Removed version update Version control is maintained through go.mod file Modified harness to only kill the application if not responded after 60 seconds in windows
* 28ac65f Merge pull request #185 from notzippy/go-mod
* 5070fb8 Fixed issue with new and run flag Updated tests to run final test in non gopath, with new name
* 904cfa2 Added some informational messages while download
* 223bd3b Added manual scan on packages in app folder This allows for source code generation. Packages in <application>/app folder are scanned manually as opposed to the `packages.Load` scan which will fast fail on compile error, and leave you with go files with no syntax.
* 4987ee8 Added verbose logging to building / testing a no-vendor app Removed section which raises an error when examining packages, we dont need to check for errors on foreign packages since we are importing only a slice of the data
* 4bab440 Updated Revel command Added a check to see if harness had already started, saves a recompile on load Added check to source info for local import renames Removed the go/build check for path and just check existence of the path Formatting updates
* 741f492 Updated scanner Removed scanning all the import statements, this is not needed Added recursive scan for revel import path to pick up testunits
* 60b88a4 Merge pull request #180 from notzippy/go-mod
* 49eef29 Build and Historic build updates Modified GOPATH to not modify build with go.mod Updated go.mod to version 1.12 Updated harness to setup listener before killing process Updated notvendored flag to --no-vendor Updated command_config to ensure no-vendor can be build Added additional checks in source path lookup
* 9d3a554 Updates Updated NotVendored flag Updated travis matrix Updated build log
* 36bd6b9 Corrected flags
* 1d9df25 Moved test cases to run last
* ad694c0 Debug travis
* fb4b565 Debug travis Added verbose flag so we can see what is occurring, Removed checkout for revel, not needed anymore
* 20d5766 Added gomod-flags Added a gomod-flags parameter which allows you to run go mod commands on the go.mod file before the build is performed. This allows for development environments.
* 0920905 Updated to build go 1.12 and up Modified to use fsnotify directlyUpdated travis to not use go deps
* 31cb64e Check-in of command_test, remaps the go mod command to use the develop branch.
* 33abc47 Fixed remaining test
* 86736d6 Updated formating Ran through testing individually for vendored Revel applications
* 07d6784 Restructured command config Removed go/build reference in clean
* c1aee24 Corrected version detection, so that equal versions match
* f2b54f5 Updated sourceinfo Added packagepathmap to the SourceInfo, this in turn allows the RevelCLI app command to pass the source paths directly to Revel directly Added default to build to be "target" of the current folder Renamed source processor
* 3f54665 Added processor to read the functions in the imported files, and populate the SourceInfo object the same as before
* 548cbc1 Upatede Error type to SourceError Added processor object to code Verified compile errors appearing Signed-off-by: notzippy@gmail.com
* 9a9511d Updated so revel new works and revel run starts parsing the source.
* acb8fb6 Initial commit to go mod
* d201463 Merge pull request #176 from xXLokerXx/fix_windows_path
* 773f688 Merge branch 'develop' into fix_windows_path
* ca4cfa5 Merge pull request #165 from kumakichi/fixed_import_C
* 4368690 Merge pull request #179 from Laur1nMartins/Laur1nMartins/fix-linkerFlags
* cf2e617 Merge branch 'develop' into Laur1nMartins/fix-linkerFlags
* 424474a Fix linker flags inclusion in build comamnd
* 6d8fcd9 Fix sintax error
* aa459c1 Fix sintaxis error
* 0b23b3e Fix complexity
* 3f65e1e acept slash and inverted slash in src path validation
* 7dce3d8 fixed import "C"
* 5c8d5bc develop v1.0.0-dev

[[revel/config](https://github.com/revel/config)]

* no changes

[[revel/modules](https://github.com/revel/modules)]

* e1fdc01 Merge pull request #103 from revel/master
* 80d53e2 Merge pull request #102 from notzippy/go-mod
* 2048fce Updated build processor
* 19728d3 Added gomod removed vendor specific imports
* 515369e develop v1.0.0-dev

[[revel/cron](https://github.com/revel/cron)]

* no changes

[[revel/examples](https://github.com/revel/examples)]

* 2d2968c Merge pull request #57 from notzippy/go-mod
* dc75997 Updated examples Updated booking app to go.mod Updated chat, facebook, others app to add in go file in the root Updated travis to run tests in windows Updated travis to exclude testing fasthttp on windows
* 5b25a51 Removed persona from project, this function no longer exists in browsers

[[revel/revel.github.io](https://github.com/revel/revel.github.io)]

* 6cd3647 Merge pull request #196 from aacapella/feature/same-site-cookies
* 9f8f537 Merge pull request #191 from dmjones/session-value-not-found-returns-error
* d79c912 Merge pull request #194 from DGKSK8LIFE/patch-1
* 3911471 Merge pull request #195 from notzippy/develop
* 67b088f Same site cookie setting
* f5c5cb0 Corrected issues
* bba502d Update for gomod docs
* 9765ef0 Merge remote-tracking branch 'revel/master' into develop
* eedc235 fixed spelling error
* 9b9270a Explain return value when session value not found
* 24abe9a Merge pull request #184 from manfordbenjamin/master
* 4969200 Change logo and apply blue theme style to all pages
* 844fe5d Revamp homepage
* ef54af7 develop v1.0.0-dev

[[revel/heroku-buildpack-go-revel](https://github.com/revel/heroku-buildpack-go-revel)]

* no changes

