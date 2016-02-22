
# Contributing to Class Complete

Thanks for taking the time to contribute to Class Complete.

Currently, contributing to Class Complete is not very... elegant.

## How To

1. `apm develop class-complete`
2. `cd <class-complete clone directory>`
3. `atom -d .`

After the project has been loaded, locate the `templates/` directory inside `lib/`, and create a new file ending in `.coffee`.

### Example contents
```coffeescript
class JavaTemplate extends Template

	constructor: ->
		super

	generateClass: (classdef) ->
		# See "javascript.coffee" for an example.
		# Insert code here...

	generateMethod: (className, method, parameters, type = "member", body = {}) ->
		# See "javascript.coffee" for an example.
		# Insert code here...

return new JavaTemplate
```
When you have created your class create a pull request. The request will be moderated, and eventually added to the plugin.

## In the future
In the future I aim to make Class Complete completely modular, in order to remove the need for pull requests. 
