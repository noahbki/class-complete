
# Contributing to Class Complete

Thanks for taking the time to contribute to Class Complete.

## How To

### Creating an addon
Creating an addon for class-complete is a little complex.

See [java-class-complete](https://github.com/anotherfrog/java-class-complete) for an example.

1. Generate a new package from within Atom.
2. Open `package.json` and add the following:
    ```json
    "consumedServices": {
        "classcomplete": {
            "versions": {
                "^1.0.0": "consumeClasscomplete"
            }
        }
    }
    ```
    Then remove `activationCommands` or `activationEvents` from `package.json`.

3. Add the following function to the main file (default: `lib/your-package-name.coffee`)
    ```coffeescript
    consumeClassComplete: (addTemplate) ->
        templateInfo =
            "name": <template-name>
            "complete":
                require <path-to-completion-manager>
            "fileTypes":
                [<filetype1>, <filetype2>, ...]
        addTemplate(templateInfo)
    ```
4. Create a new file. It must have the same name as `<path-to-completion-manager>`, and be in the same directory as your main file.
5. Three methods must be created:
    ```coffeescript
    generateClass: (classdef) ->
        # ...

    generateMethod: (className, method, parameters, type = "member", body = {}, classdef) ->
        # ...

    indent: (text, indent) ->
        buffer = ""
        lines = text.split(/\n|\r\n/)

        prefix = ""
        prefix += "#{@tabString}" for i in [0..indent - 1]

        for line in lines
            buffer += prefix + line + "\n"

        return buffer

    module.exports = new <ClassNameHere>
    ```
6. Reload atom, and test away :)

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
