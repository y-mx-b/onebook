import Foundation

struct BookmarkManager {
    var browserName: String? = nil
    var bookmarksFilePath: String? = nil
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"

    func create(_ bookmarkPath: String?, siteURL: URL?) {
        // TODO: add bookmarks
        // - create intermediate folders (if neccessary)
        // - create bookmark file
        // - create new GUID
        // - insert necessary information into bookmark file
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
