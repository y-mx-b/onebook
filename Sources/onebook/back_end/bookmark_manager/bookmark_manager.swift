import Foundation

struct BookmarkManager {
    var browserName: String? = nil
    var bookmarksFilePath: String? = nil
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"

    func create(_ bookmarkPath: String?, siteURL: URL?) {
    // TODO: add bookmarks
    }

    func remove() {
    // TODO: remove bookmarks
        // remove files
        // if folder is empty, ask to remove
    }

    func clean() {
    // TODO: remove empty bookmark folders
    }

    func sync() {
    // TODO: sync bookmarks between browsers (this might take a while)
    }
}
