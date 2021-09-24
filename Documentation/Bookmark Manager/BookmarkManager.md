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
func create(_ bookmarkPath : String, siteURL : String) -> Bool {...}
```

A function used to create bookmarks. Functional, but needs improving.
Returns true if the bookmark is successfully created, false if the
operation failed.

### remove

``` swift
func remove(_ bookmarkPath: String) -> Bool {...}
```

A function used to remove bookmarks. Functional, but needs improving.
Returns true if the bookmark is successfully created, false if the
operation failed.

### clean

``` swift
func clean() {...}
```

A function used to remove empty bookmark folders. Not yet implemented.

### sync

``` swift
func sync() {...}
```

A function used to sync browser bookmarks with Onebook's bookmarks. Not
yet implemented.

## Extensions

### [ChromiumBookmarkManager](https://github.com/luardemin/onebook/blob/master/Documentation/Bookmark%20Manager/Extensions/Chromium/ChromiumBookmarkManager.md)

A struct containing properties and methods specificically related to
Chromium/Chrome bookmarks.

### [SafariBookmarkManager](https://github.com/luardemin/onebook/blob/master/Documentation/Bookmark%20Manager/Extensions/Safari/SafariBookmarkManager.md)

A struct containing properties and methods specificically related to
Safari bookmarks
