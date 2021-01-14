
# Class Complete

Class Complete is a plugin for the Atom text editor, and allows users to easily generate code from shorthand.

## Table of Contents
- [How-To](#how-to)
	- [Parameters](#parameters)
	- [Methods](#methods)
	- [Extending Classes](#extending)
- [Examples](#examples)
    - [Class](#simple-class-creation)
    - [Class with parameters](#class-with-parameters)
    - [Class with member parameters](#class-with-member-parameters)
    - [Class with type checking](#class-with-parameters-and-type-checking)
    - [Class with instance checking](#checking-instance)
 - [Examples with Methods](#class-with-methods)
    - [Member method](#member-method)
    - [Static method](#static-method)
    - [Member methods and parameters](#member-method-with-parameters)
    - [Extending classes](#extending-classes)
    - [All together](#all-together)

## Contributing
In the future, it will be easier to contribute to it's development. For now please read CONTRIBUTING.md.

## How-to
All you need to write is a classdef
(Class Definition) that describes the class you want to create, select it, then press `<ctrl-shift-space>`.

The basic structure of a classdef is as follows: `<class_name>:<parameters>;<methods>:<extending_class_name>`.

### Parameters
The `<parameter>` section is structured as follows: `(@)<name>((!|^)<(type|instance)>), ...`.

 - `@` - Argument will become a member variable.
 - `!<type>` - Ensure the argument is the correct type
 - `^<instance>` - Ensure the argument is the correct instance

### Methods
The `<methods>` section is structured as follows: `(@)<name>(+<arguments>, ...)/...`.  
 - `@` - The method is static
 	- Leaving this blank with make it a member

### Extending
The `<extending_class_name>` section defines the class that the new class will extend.

## Examples

### Simple class creation
*These examples are for JavaScript.*

The classdef `Class` becomes:

```javascript
Class = (function() {
	function Class() {
	}

	return Class;
}());
```

### Class with parameters

The classdef `Class:a,b,c` becomes:

```javascript
Class = (function() {
	function Class(a, b, c) {
	}

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
	}

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
	}

	return Class;
}());
```

#### Checking instance

The classdef `Class:a^Class2` becomes:

```javascript
Class = (function() {
	function Class(a) {
		if (!(a instanceof Class2)) throw new Error("Parameter 'a' expects to be instance of 'Class2'");
	}

	return Class;
}());
```

### Class with methods

#### Member method

The classef `Class:;hello` becomes:

```javascript
Class = (function() {
	function Class() {
	}

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
	}

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
	}

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
	}

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
	}

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
