# Class Complete

An easy to use package for quickly creating JavaScript classes.

## Usage

### Without parameters
```
Class <ctrl-shift-space>
```
generates
```javascript
Class = (function() {
    function Class() {

    }

    return Class;
}());
```

### With parameters
```
Class:foo,bar,apples <ctrl-shift-space>
```
generates
```javascript
Class = (function() {
    function Class(foo, bar, apples) {

    }

    return Class;
}());
```

### Extending classes
```
Class:foo,bar,apples:Vector <ctrl-shift-space>
```
generates
```javascript
Class = (function() {
	function Class(foo, bar, apples) {
		Vector.apply(this);
	}

	Class.prototype = Object.create(Vector.prototype);
	Class.prototype.constructor = Class

	return Class;
}());
```

![A screenshot of your package](http://i.imgur.com/cQCvAAz.png)
