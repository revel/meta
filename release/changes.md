deps
# CHANGELOG

## v0.21.0

[[revel/revel](https://github.com/revel/revel)]

* d76f3ec Merge pull request #1404 from notzippy/develop
* e8b4839 Bug fix, not reuse controllers Moved SimpleStack into utils folder Added RevelContainer Moved controller stacks inside revelcontainer Added option to not reuse controllers via `revel.controller.reuse`
* 08d8d9d Merge pull request #1403 from notzippy/develop
* bf256fd Added getKeys() for the header Updated usage closes #1391
* 842eeae Merge pull request #1401 from HaraldNordgren/go_versions
* 12a1b90 Bump Go versions and use '.x' to always get latest minor versions
* 7b96469 Merge pull request #1399 from notzippy/develop
* 613a1f2 Small enhancements Added stack to errors Added stack information to router when forumlating error
* 0610c3e Merge pull request #1397 from ptman/patch-1
* adfd82f Fix compilation error
* 382fb5a Merge pull request #1394 from notzippy/develop
* a1ca909 Merge pull request #1396 from dnamsons/fix-spelling-errors
* f6187f2 Fix spelling errors from go report
* fba1f4b Removed deprecated loggers
* 68a6460 Updated travis , made windows success optional
* 5c6836e Merge pull request #1393 from notzippy/develop
* 7033e40 Small enhancements Exposed StopServer function to public Changed session filter to use empty call
* 2ae752b Merge pull request #1390 from notzippy/code-reformat
* a13d702 Fix logger issue
* 30f8c4f Merge pull request #1389 from notzippy/code-reformat
* cd4dc58 Fixed issues with session test
* 6ab8463 Merge pull request #1388 from notzippy/code-reformat
* a77db07 Merge pull request #1387 from notzippy/session-engine-3
* f760886 Merge pull request #1386 from notzippy/shutdown-update
* b52953f Merge pull request #1385 from notzippy/template-error
* 7ce779c Merge pull request #1382 from notzippy/session-engine-2
* c6e2cfb Ran gofmt -s -w
* 577ae8b Enhancement pack for next release Added session engine support, and the session cookie engine breaking change revel.Session was map[string]string now is map[string]interface{}
* 93d7ca8 Updated test cases Updated shutdown to support windows environment Patched shutdown support to make it work through the event engine Added ENGINE_SHUTDOWN_REQUEST to events, raising this event will cause the server to shutdown Assigned Server engines to receive revel.Events Added revel.OnAppStop hooks - breaking change, was revel.OnAppShutdown Removed revel.OnAppShutdown Normalized startup / shutdown hooks into their own package
* 47158ea Fixed template bug The template was not displaying the source code when an error occurred this fixes that
* 4ae50af Logger Enhancement Further isolated dependencies on log 15 to just the revel_logger package All handlers are declared locally Added test cases Fixed bugs Documented rules
* 9073a7e Merge pull request #1372 from revel/master
* 96f1099 develop v0.21.0-dev
* 3762042 Fix changes from other mergesAdds session engine support. Configurable session engine, register interface revel.SessionRegisterSessionEngine(f func() revel.SessionEngine, name string) Session engine is choosen from app.conf value session.engine Currently only engine type is revel-cookie. Adds the feature to store interface{} session from controller using SessionMarshal, SessionUnmarshal, SessionDelete.

[[revel/cmd](https://github.com/revel/cmd)]

* facfe0e Merge pull request #159 from notzippy/develop
* ee53d2f Patchset for 21 Added Version -u to update the checked out libaraies Enhanced new skeleton toto support http https and git schemas when cloning the skeleton repo. Enhanced version command to fetch server version from master branch Enhanced version command to update local repository if a new version exists on the server
* 3c48e1f Merge pull request #158 from hwsoderlund/fix_compile_error
* 19fb7d6 Fix compilation error visibility
* 1e7b532 Merge pull request #157 from HaraldNordgren/go_versions
* 205c652 Bump Go versions and use '.x' to always get latest patch versions
* 3de8b8c Merge pull request #156 from notzippy/develop
* 4a877b2 Modified run command to translate symlinks to absolute paths
* a0bafdc Merge pull request #155 from notzippy/develop
* cdef0b7 Added ability to readback output from command line Updated readme
* e0d3f83 Merge pull request #153 from notzippy/develop
* 87c9e56 Tool updates Updated tool to give more meaningful errors Added file system as an option to fetch the skeleton from
* 554e625 Merge pull request #152 from notzippy/develop
* 32a3f08 Allow windows to fail on travis since to address a bug on current master
* e6e1cad Merge pull request #148 from notzippy/develop
* 5e36cb1 Updated travis to use checkout matching branch of Revel Framework for build.
* 8c21a56 Revel tool enhancements * run Command will choose CWD if no additional arguments are supplied * Added Revel version check, compatible lists are in model/version
* 031fde6 Update to logger
* 09ca80a Merge pull request #151 from lujiacn/master
* 2d6c2ee Update build.go

[[revel/config](https://github.com/revel/config)]

* a81c410 Merge pull request #12 from revel/master

[[revel/modules](https://github.com/revel/modules)]

* 2004e06 Merge pull request #95 from notzippy/develop
* db4e6ed Moved SimpleStack to new package
* 5478708 Added go get to fetch the test cases dependency Modified allowed failures to version 1.8 fast http uses github.com/klauspost/compress which uses math/bits introduced in version 1.9 of Go Windows builds are "flakey" so disabled them from changing the results
* ed10a4c Merge pull request #94 from notzippy/develop
* 54cf5f2 Patchset v0.21 Added additional test cases Added version.go file Updated FastHTTPServer, GOTestServer to implement new GetKeys() Additional documentation
* 7800165 Merge pull request #93 from revel/master
* bdf48fb Merge pull request #92 from notzippy/develop
* beaae3f Fixed import error
* 717d81e Merge pull request #91 from notzippy/develop
* b8b02f4 Reorganization, readme updates Moved auth example into its own folder Updated root readme Updated CSRF
* 32c2c83 Merge pull request #90 from notzippy/develop
* 7b66c65 Found old logger statement, updated
* ab8de1d Merge pull request #89 from notzippy/develop
* a3b6d49 Removed old logger
* c8b7cbd Merge pull request #88 from notzippy/develop
* 9e06773 Fix CSRF The google http server does not fully populate the Request.URL so this check fails. closes #83
* f17799d Merge pull request #87 from notzippy/develop
* 7406b4f Added in code to shutdown server properly
* 66cdf97 Merge pull request #86 from notzippy/develop
* 3d09446 Corrected some issues with test_suite
* 4c4a251 Merge pull request #85 from notzippy/develop
* ab908ee Updated CSRF test cases Added travis modified test engine
* 46a140c Merge pull request #84 from notzippy/develop
* b545a18 Updated to use the revel.StopServer
* 8011b77 Reformatted code
* 37b34b8 Updated modules to support OnAppStop functionality Enhanced fasthttp server to support shutdown

[[revel/cron](https://github.com/revel/cron)]

* no changes

[[revel/examples](https://github.com/revel/examples)]

* dcd9daf Merge pull request #53 from notzippy/develop
* 42aee59 Fixed issue with error checking closes #52
* 66dd813 Merge pull request #51 from notzippy/develop
* 917bf1a Updated examples Updated booking module to work with changed session Updated to remove any references to old log messages

[[revel/revel.github.io](https://github.com/revel/revel.github.io)]

* af214b3 Merge pull request #181 from notzippy/develop
* eb2b456 Updated revel tool to reflect changes in revel/cmd
* 97ee610 Merge pull request #180 from revel/master
* fbff2b8 Merge pull request #179 from notzippy/develop
* 7a5f03f Updated dep version, added some information
* e27e812 Merge pull request #178 from notzippy/develop
* 62e1aa4 Updated Documents Updated header to add in links to pages Alter layout to fluid Added Startup , Stop section Added github repo Skeletons reference Forced code min-wdth 1000px Updated booking example to reflect changes to app Updated main page to reflect changes to Revel Added new keys details Updated concepts description to include reference to the engines and mux Added new mux page Removed revel.TRACE loggers Added vendor organization Added session enging Updated session description Updated startup stop section Updated tool description Added using vendor and deps Added new quick reference points Updated  tutorial
* a54f9dc Fixed spelling

[[revel/heroku-buildpack-go-revel](https://github.com/revel/heroku-buildpack-go-revel)]

* no changes

