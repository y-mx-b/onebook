import Foundation

struct BookmarkManager {
    var browserName: String?
    var bookmarksFilePath: String?
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"

    func create(_ bookmarkPath: String, siteURL: String) -> Bool? {
        // TODO: make the method safer
        // - Don't overwrite existing files
        // - Check to make sure a folder of the same name doesn't exist
        // - Check to make sure the URL is valid
        //   - If it isn't, ask for confirmation

        let fileManager = FileManager.default

        let fullPath = (storageDirectory + bookmarkPath).replacingOccurrences(of: "//", with: "/")
        let directoryPath = fullPath.components(separatedBy: "/").dropLast(1).joined(separator: "/")
        let siteURLasURL = URL(string: siteURL)

        let bookmarkContents = Data("""
        url = \(String(describing: siteURLasURL!))
        date_added = \(Date().timeIntervalSince1970)
        guid = \(UUID().uuidString)
        """.utf8)

        try! fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
        if fileManager.createFile(atPath: fullPath, contents: bookmarkContents) {
            return true
        } else { return false }
    }

    func edit() {
        // TODO: allow for editing bookmarks with $EDITOR
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
