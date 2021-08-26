# BookmarkManager

``` swift
struct BookmarkManager {...}
```

## Properties

### browserName

``` swift
var browserName: String?
```

The name of the browser. Has a default value of `nil`.

### bookmarksFilePath

``` swift
var bookmarksFilePath: String?
```

A string with the path to a bookmark file. Has a default value of `nil`.

### storageDirectory

``` swift
var storageDirectory: String?
```

A string with the path to the local bookmark storage directory used by
Onebook. Has a default value of `"\(NSHomeDirectory())/.bookmarks/"`.

## Methods

### create

``` swift
func create(_ bookmarkPath : String, siteURL : String) {...}
```

A function used to create bookmarks. Functional, but needs improving.

### remove

``` swift
func remove() {...}
```

A function used to remove bookmarks.

### clean

``` swift
func clean() {...}
```

A function used to remove empty bookmark folders.

### sync

``` swift
func sync() {...}
```

A function used to sync browser bookmarks with Onebook's bookmarks.

## Extensions

### [ChromiumBookmarkManager](./Extensions/Chromium/ChromiumBookmarkManager.org)

A struct containing properties and methods specificically related to
Chromium/Chrome bookmarks.

### [SafariBookmarkManager](./Extensions/Safari/SafariBookmarkManager.org)

A struct containing properties and methods specificically related to
Safari bookmarks
