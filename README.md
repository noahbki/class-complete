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
Class:foo,boo,apples <ctrl-shift-space>
```
generates
```javascript
Class = (function() {
    function Class(foo, boo, apples) {

    }

    return Class;
}());
```

![A screenshot of your package](http://i.imgur.com/cQCvAAz.png)
