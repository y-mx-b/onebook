# ChromiumBookmarkManager

``` swift
extension BookmarkManager {
    struct ChromiumBookmarkManager {...}
}
```

A struct with properties and methods pertaining to Chromium/Chrome
bookmarks.

## Properties

## Methods

### getBookmarks

``` swift
public func getBookmarks(from bookmarksFilePath: URL) -> Data? {...}
```

A method to retrieve Chromium or Chrome bookmarks from the file
specified at the URL given as a parameter. Returns `Data?`.

### parseBookmarks

``` swift
public func parseBookmarks(_ bookmarksDump: Data?) -> ChromiumBookmarks? {...}
```

A method to parse the bookmark data provided to it as a parameter.
Returns `ChromiumBookmarks?`.

### storeBookmarks

``` swift
public func storeBookmarks(_ bookmarksData: ChromiumBookmarks, storeAt storageDirectory: String) {...}
```

A method to store the bookmarks (of type `ChromiumBookmarks`) provided
to it as a parameter, at the directory provided as a parameter, which is
given as a string. Null return.
