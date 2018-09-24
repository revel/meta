deps
# CHANGELOG

## v0.20.0

[[revel/revel](https://github.com/revel/revel)]

* 383a5e1 Merge pull request #1370 from notzippy/develop
* bfddb60 Modified handler to be func(typeOf revel.Event, value interface{}) (responseOf revel.EventResponse) Broke out event sending and constants into their own class
* 9bf125f Merge pull request #1369 from notzippy/develop
* 6c48cb0 Updated minimum GO version and modified fsnotify import
* fdb14c8 Merge pull request #1368 from notzippy/develop
* f65f5b1 Added some features Added hard fail REVEL_FAILURE event Added HTTP_REQUEST_CONTEXT fetch Breaking change function  `Request.Context() map[string]interface()` renamed to  `Request.Args() map[string]interface()` new function added  `Request.Context() context.Context`
* 2cb726f Merge pull request #1367 from notzippy/develop
* 28687af Updated travis, Fixed session test to compare on UTC times Added 5 retries for GetCustom test
* 66f0275 Merge pull request #1366 from notzippy/develop
* 8d67b61 Updated watcher to run updates in parallel to prevent delayed multiple compiles Updated travis to test only go 1.8 and above
* d19c79b Incremental updates Updated logger functionality Added option to pass in mode as a JSON object. This allows execution of test cases at different then normal levels. Fixed the rendering of error messages for templates. So that they are displayed properly now Added some additional documentation and cleaned some code
* e8bba3e Merge pull request #1224 from zuoRambo/feature/graceful-shutdown
* b9be311 Merge pull request #1365 from revel/master
* 5bad366 Merge pull request #1312 from lokhman/feature/better-required-validator
* 4dd8596 Merge pull request #1333 from notzippy/json_websocket_update
* f44841b Merge pull request #1358 from Heinoc/develop
* cc08741 fix template_engine.go's DEBUG bug of command "revel version";
* 427b91e Added websockets Message.Send / Message.Receive functions.
* ec3e765 Merge pull request #1332 from notzippy/develop
* 7f40999 Updated MIT license
* 15b3937 Fix typos in required validator
* 112cb29 Update required validator to validate zero-length values
* f0f2e00 Merge pull request #1316 from notzippy/func_logger
* 36312cf Added functional logger.
* 4699f07 Merge pull request #1315 from Zauberstuhl/log_output
* 3bcfd78 Remove unnecessary log output in results.go
* 10c5484 Use reflect.DeepEqual to support not comparable types (e.g. func)
* 6791e46 Remove time from imports
* eb9c880 Return standardised default message
* 4e97651 Simplify validator to support all possible object types
* 6ac3015 develop v0.20.0-dev
* 3b55281 GoHttpServer support graceful shutdown; add OnAppShut
* 89b25f7 Merge branch 'master' into feature/graceful-shutdown
* 2e5ecfa import facebookgo/grace/gracehttp to support graceful shutdown
* b8ee27a resolve confilct
* 61a5805 Merge remote-tracking branch 'origin/develop' into feature/graceful-shutdown
* b59a6bd Retargets #593 and cleans up the code a bit
* eceec1f Runtime errors fixed, signal polishing
* b4033b5 added OnAppShutdown hook
* 2a8a56f graceful server shutdown
* 8656660 shutdown hooks

[[revel/cmd](https://github.com/revel/cmd)]

* b606ec9 Merge pull request #138 from notzippy/develop
* 01ccd69 Re added the requirement for the -a, without this the flags would not error out and cause issues
* cfe5bf4 Merge pull request #137 from notzippy/develop
* 7a4e741 Added a version file to revel/cmd Updated import path detection to make it smarter. You can now use absolute paths etc..
* 92943b2 Merge pull request #136 from notzippy/develop
* 69e59ef New Enhancement Added ability to create a new revel applicaiton without any sources. Automatically download all sources required
* 5973b43 Merge pull request #135 from notzippy/develop
* c47f447 Added message for debugging Added process state message to be returned to wait channel to help resolve the reason for the "app died" message
* b138e35 Merge pull request #134 from notzippy/develop
* 17459d1 Split main file Added code to split the generated main file into two separate files. This allows other code to launch the web application inline.
* c87d53e Merge pull request #133 from notzippy/develop
* 4d7a290 Updated readme, Updated travis
* 7eff69f Merge pull request #130 from notzippy/develop
* 34bc650 Added CI
* 2c53671 Merge pull request #129 from notzippy/develop
* 3ad381d Enhanced package and build to by default not include any source code
* d0baaeb Initial rewrite of revel/cmd to provide vendor support and enhanced CLI options
* d2ac018 Merge pull request #120 from lokhman/issue119
* d0e5c79 Merge pull request #122 from notzippy/develop
* 7e501b8 Added missed GPL license to command
* fe56bdd Fix DefaultValidationKeys generated with wrong line for multiline check

[[revel/config](https://github.com/revel/config)]

* no changes

[[revel/modules](https://github.com/revel/modules)]

* 5b32282 Merge pull request #81 from notzippy/develop
* cf8fce9 Missed a type change
* f11f12d Merge pull request #80 from notzippy/develop
* 8f290c0 Updated because of type change in Revel
* 1a0eae9 Merge pull request #79 from notzippy/develop
* 083309b Merge remote-tracking branch 'remotes/revel/master' into develop
* 798be6f Merge pull request #78 from notzippy/develop
* b26569c Added gohttptest suite For go coverage
* 33d2892 Updated static package, moved the model into a package called model Added schema to the gorp package
* 9154eed Merge pull request #77 from olivierlemasle/fixace
* 1650355 Fix Ace template for error 403
* 7fa7471 Merge pull request #71 from wariosolis/develop
* 301a4c1 Merge pull request #72 from ptman/patch-1
* bc76c31 Merge pull request #73 from notzippy/develop
* f9eaf8f Added missed MIT license
* 03baf1b Provide csrftoken on first result of session
* 2f861cb Gorm - support for non-default database port

[[revel/cron](https://github.com/revel/cron)]

* no changes

[[revel/examples](https://github.com/revel/examples)]

* 4dc1669 Merge pull request #50 from notzippy/develop
* 0f077e3 Removed go 1.8, fasthttp is not compatible with this version so the tests would not function
* 2bc7266 Merge pull request #49 from notzippy/develop
* ecebaeb Added second booking application, updated travis to test. Added test for fasthttp server
* cd43d38 Merge pull request #48 from notzippy/develop
* b9615d6 Try different version of go1.8
* 43021ec Merge pull request #47 from notzippy/develop
* 7526295 Updated booking application to add test for coverage Added watch.mode=eager
* 2c29790 Merge pull request #44 from uplus/fix_chat_websocket
* 086f597 fix chat websocket example
* 413481b Merge pull request #43 from notzippy/develop
* b508f3f Websocket example fix closes #41
* d540397 Merge pull request #35 from ptman/patch-1
* 40530c1 Merge pull request #42 from notzippy/develop
* 5a196a1 Added missed GPL license to examples
* 8475398 Fixing remains of Id -> ID cleanup

[[revel/revel.github.io](https://github.com/revel/revel.github.io)]

* b8cc7f7 Merge pull request #174 from revel/master
* 59992a3 develop v0.20.0-dev

[[revel/heroku-buildpack-go-revel](https://github.com/revel/heroku-buildpack-go-revel)]

* no changes

