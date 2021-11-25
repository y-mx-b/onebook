import Foundation
import BookmarkParser

struct BookmarkManager {
    var storageDirectory: String = try! ConfigManager().loadPreferences().storageDirectory

    func getFullPath(_ bookmarkFilePath: String) -> String {
        return storageDirectory + bookmarkFilePath
    }

    // Direct Management
    func createBookmark(at bookmarkPath: String, siteURL: String) throws {
        let fm = FileManager.default
        let data = siteURL.data(using: .utf8)
        if !fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil) {
            let pathArray = bookmarkPath.components(separatedBy: "/").dropLast()
            try fm.createDirectory(atPath: pathArray.joined(separator: "/"),
                               withIntermediateDirectories: true,
                               attributes: nil)
            fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil)
        }
    }

    func edit(_ bookmarkPath: String) {
    }

    func removeBookmark(_ bookmarkPath: String) throws {
        let fm = FileManager.default
        try fm.removeItem(atPath: bookmarkPath)
    }

    func renameBookmark(_ originalPath: String, to newPath: String) throws {
        let fm = FileManager.default
        let bm = BookmarkManager()
        _ = try fm.replaceItemAt(URL(fileURLWithPath: bm.getFullPath(newPath)),
                         withItemAt: URL(fileURLWithPath: bm.getFullPath(originalPath)))
    }

    // Automated Management
    func cleanBookmarks() {
    }

    func importBookmarks(_ browser: Browser, at storageDirectory: String) throws -> Bool {
        return false
    }

    func syncBookmarks(_ browsers: [String]) {
    }
}
