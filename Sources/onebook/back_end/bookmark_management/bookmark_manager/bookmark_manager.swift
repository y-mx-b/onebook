import Foundation

struct BookmarkManager {
    var browserName: String?
    var bookmarksFilePath: String?
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"

    func check(_ bookmarkPath: String?) throws -> Bool? {
        // true = file exists
        // false = folder,  not file,
        // nil = no file, no folder, or error
        guard let input = bookmarkPath else { return nil }

        let fileManager = FileManager.default

        if fileManager.fileExists(atPath: bookmarkPath!) {
            var unsafeFalse: ObjCBool = false
            if fileManager.fileExists(atPath: bookmarkPath!, isDirectory: &unsafeFalse) { return(true) }
        } else { return(false) }
        return(nil)
    }

    func create(_ bookmarkPath: String?, siteURL: URL?) {
        // TODO: add bookmarks
        // - create intermediate folders (if neccessary)
        // - create bookmark file
        // - create new GUID, date
        // - insert necessary information into bookmark file
    }

    func move(_ originalPath: String?, to newPath: String?) {
        // TODO: check if file or folder, move accordingly
    }

    func remove(_ bookmarkPath: String?) {
        // TODO: remove bookmarks
        // remove files
        // if folder is empty, ask to remove
    }

    func clean() {
        // TODO: remove empty bookmark folders
    }

    func sync(_ browsers: [String]) {
        // TODO: sync bookmarks between browsers (this might take a while)
    }
}
