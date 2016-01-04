
# Class Complete

Class Complete is a package for Atom that makes the creation of JavaScript classes easier than ever.

## How-to

All you need to write is a classdef
(Class Definition) that describes the class you want to create, select it, then press `<ctrl-shift-space>`.

The basic structure of a classdef is as follows: `<class_name>:<parameters>;<methods>:<extending_class_name>`.

### Parameters

The `<parameter>` section is structured as follows: `(@)<name>((!|^)<(type|instance)>), ...`.  If you place a `@` at the beginning of the parameter it will add the argument as a member variable with the same name.  If you add `!<type>` to the end of your parameter then an if block will be added to the top of the created constructor or function that checks if the type of the parameter is the `<type>` specified; if you add `^<instance>` then the if will check if the parameter is the same `<instance>`.

### Methods

The `<methods>` section is structured as follows: `(@)<name>(+<arguments>, ...)/...`.  If you place a `@` at the beginning of the method the the generated method will be a static method whereas without it would be a member.

### Extending

The `<extending_class_name>` section defines the class that the new class will extend.

## Examples

### Simple class creation

The classdef `Class` becomes:

```javascript
Class = (function() {
	function Class() {
	};

	return Class;
}());
```

### Class with parameters

The classdef `Class:a,b,c` becomes:

```javascript
Class = (function() {
	function Class(a, b, c) {
	};

	return Class;
}());
```

### Class with member parameters

The classdef `Class:@a,@b,@c` becomes:

```javascript
Class = (function() {
	function Class(a, b, c) {
		this.a = a;
		this.b = b;
		this.c = c;
	};

	return Class;
}());
```

### Class with parameters and type checking

#### Checking type

The classdef `Class:a!string` becomes:

```javascript
Class = (function() {
	function Class(a) {
		if (typeof a !== "string") throw new Error("Parameter 'a' expects to be type 'string'");
	};

	return Class;
}());
```

#### Checking instance

The classdef `Class:a^Class2` becomes:

```javascript
Class = (function() {
	function Class(a) {
		if (!(a instanceof Class2)) throw new Error("Parameter 'a' expects to be instance of 'Class2'");
	};

	return Class;
}());
```

### Class with methods

#### Member method

The classef `Class:;hello` becomes:

```javascript
Class = (function() {
	function Class() {
	};

	Class.prototype.hello = function() {
	};

	return Class;
}());
```

#### Static method

The classdef `Class:;@hello` becomes:

```javascript
Class = (function() {
	function Class() {
	};

	Class.hello = function() {
	};

	return Class;
}());
```

#### Member method with parameters

The classdef `Class:;hello+name,age` becomes:

```javascript
Class = (function() {
	function Class() {
	};

	Class.prototype.hello = function(name, age) {
	};

	return Class;
}());
```

### Extending classes

The classdef `Class::Class2` becomes:

```javascript
Class = (function() {
	function Class() {
		Class2.apply(this, arguments);
	};

	Class.prototype = Object.create(Class2.prototype);
	Class.prototype.constructor = Class;

	return Class;
}());
```

### All together

The classdef `Person:@name!string,@age!number;setName+@name!string/setAge+@age!number/hello+name!string:Homosapian` becomes:

```javascript
Person = (function() {
	function Person(name, age) {
		Homosapian.apply(this, arguments);

		if (typeof name !== "string") throw new Error("Parameter 'name' expects to be type 'string'");
		if (typeof age !== "number") throw new Error("Parameter 'age' expects to be type 'number'");

		this.name = name;
		this.age = age;
	};

	Person.prototype = Object.create(Homosapian.prototype);
	Person.prototype.constructor = Person;

	Person.prototype.setName = function(name) {
		if (typeof name !== "string") throw new Error("Parameter 'name' expects to be type 'string'");

		this.name = name;
	};

	Person.prototype.setAge = function(age) {
		if (typeof age !== "number") throw new Error("Parameter 'age' expects to be type 'number'");

		this.age = age;
	};

	Person.prototype.hello = function(name) {
		if (typeof name !== "string") throw new Error("Parameter 'name' expects to be type 'string'");
	};

	return Person;
}());
```

### RequireJS

The line `r:express` becomes:
```javascript
var express = require("express");
```

### RequireJS with different filenames/formats

Ths line `r:express:Marshmallow.js` becomes:
```javascript
var express = require("Marshmallow.js");
```
