# SimplePath

SimplePath is a library for dealing with file paths in Swift. It borrows heavily from other languages such as [Go][golang-filepath], [PHP][php-basename], [C][c-dirname] and [Perl][perl-basename], and runtimes such as [Node.js][nodejs-path].

This library doesn't try to hide the fact that file paths are strings. Most of its functions are just wrappers around [NSString path utilities][NSString].

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
let base = Path.split("assets/images/logo.png")

// base -> "logo.png"
```

```Swift
let base = Path.split("assets/images/logo.png", ext: "png")

// base -> "logo"
```

### Path.dirname(path)

Returns the parent directory of a path.

```Swift
let dir = Path.split("/var/data/map.bin")

// dir -> "/var/data"
```

### Path.extname(path)

Gets the extension of a path.

```Swift
let ext = Path.split("assets/sfx/drumroll.wav")

// ext -> "wav"
```

```Swift
let ext = Path.split("assets/sfx")

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
Path.isAbsolute('/var/logs/test.log') // -> true
Path.isRelative('cache/images/1.bin') // -> true
```

### Path.exists(path)

Returns true if the path exists.

```Swift
Path.isAbsolute('/path/to/existing/file.txt') // -> true
```

### Path.isDir(path)

Returns true if the path exists and it is a directory.

```Swift
Path.isAbsolute('/path/to/existing/dir') // -> true
```

[golang-filepath]: https://golang.org/pkg/path/filepath/
[php-basename]: http://php.net/manual/en/function.basename.php
[c-dirname]: https://linux.die.net/man/3/dirname
[perl-basename]: https://perldoc.perl.org/File/Basename.html
[nodejs-path]: https://nodejs.org/api/path.html
[NSString]: https://developer.apple.com/documentation/foundation/nsstring#1667898
