[![Build](https://github.com/raymondjavaxx/SimplePath/workflows/Build/badge.svg)](https://github.com/raymondjavaxx/SimplePath/actions)

# SimplePath

SimplePath is a library for working with file paths in Swift. It borrows heavily from the path libraries of other languages such as [Go][golang-filepath], [PHP][php-basename], [C][c-dirname] and [Perl][perl-basename], and runtimes such as [Node.js][nodejs-path].

This library doesn't try to hide the fact that file paths are strings. Most of its functions take strings as arguments and return strings.

## Functions

### Path.join([components])

Builds a path string by joining components, adding directory separators where necessary.

```Swift
let path = Path.join([
    "/var/www",
    "website",
    "robots.txt"
])

// path -> /var/www/website/robots.txt
```

### Path.split(path)

Returns all components of a given path.

```Swift
let components = Path.split("/storage/images/0001.jpg")

// components -> [
//   "/",
//   "storage",
//   "images",
//   "0001.jpg"
// ]
```

### Path.basename(path)

Returns the last component of a path. Usually a file name.

```Swift
let base = Path.basename("assets/images/logo.png")

// base -> "logo.png"
```

```Swift
let base = Path.basename("assets/images/logo.png", ext: "png")

// base -> "logo"
```

### Path.dirname(path)

Returns the parent directory of a path.

```Swift
let dir = Path.dirname("/var/data/map.bin")

// dir -> "/var/data"
```

### Path.extname(path)

Gets the extension of a path.

```Swift
let ext = Path.extname("assets/sfx/drumroll.wav")

// ext -> "wav"
```

```Swift
let ext = Path.extname("assets/sfx")

// ext -> nil
```

### Path.format([elements])

Builds a path, given named elements of the path.

```Swift
let path = Path.format([
    .dir:  "assets/icons",
    .base: "settings.png"
])

// path -> "assets/icons/settings.png"
```

```Swift
let path = Path.format([
    .dir:  "assets/vector",
    .base: "logo"
    .ext:  "svg"
])

// path -> "assets/vector/logo.svg"
```

### Path.isAbsolute(path) and Path.isRelative(path)

Can be used for checking if a path is absolute or relative.

```Swift
Path.isAbsolute("/var/logs/test.log") // -> true
Path.isRelative("cache/images/1.bin") // -> true
```

### Path.exists(path)

Returns true if the path exists.

```Swift
Path.exists("/path/to/existing/file.txt") // -> true
```

### Path.isFile(path)

Returns true if the path exists and is a regular file.

```Swift
Path.isFile("/path/to/existing/file.txt") // -> true
```

### Path.isDir(path)

Returns true if the path exists and is a directory.

```Swift
Path.isDir("/path/to/existing/dir") // -> true
```

## Extending

If you think SimplePath is missing important functionalty I suggest you follow these steps:

1. Implement such functionality as an [extension][swift-extensions].
2. And if you believe that the functionality is highly reusable, feel free to contribute it back to the project by opening a [pull request][pull-request].

## License

This library is licensed under [the MIT license](LICENSE).

[golang-filepath]: https://golang.org/pkg/path/filepath/
[php-basename]: http://php.net/manual/en/function.basename.php
[c-dirname]: https://linux.die.net/man/3/dirname
[perl-basename]: https://perldoc.perl.org/File/Basename.html
[nodejs-path]: https://nodejs.org/api/path.html
[swift-extensions]: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html
[pull-request]: https://github.com/raymondjavaxx/SimplePath/pulls
