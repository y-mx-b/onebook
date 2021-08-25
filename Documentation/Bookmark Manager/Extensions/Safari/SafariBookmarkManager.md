# SafariBookmarkManager

``` swift
extension BookmarkManager {
    struct SafariBookmarkManager {...}
}
```

A struct with properties and methods pertaining to Safari bookmarks.

## Properties

## Methods

### getBookmarks

``` swift
public func getBookmarks(from bookmarksFilePath: URL) -> Data? {...}
```

A method to retrieve Safari bookmarks from the file specified at the URL
given as a parameter. Returns `Data?`.

### parseBookmarks

``` swift
public func parseBookmarks(_ bookmarksDump: Data?) -> SafariBookmarks? {...}
```

A method to parse the bookmark data provided to it as a parameter.
Returns `SafariBookmarks??`.

### storeBookmarks

``` swift
public func storeBookmarks(_ bookmarksData: SafariBookmarks, storeAt storageDirectory: String) {...}
```

A method to store the bookmarks (of type `SafariBookmarks`) provided to
it as a parameter, at the directory provided as a parameter, which is
given as a string. Null return.
