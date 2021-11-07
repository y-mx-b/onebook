import Foundation

extension BookmarkManager {
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

    func renameBookmark(_ originalPath: String?, to newPath: String?) {
        let fm = FileManager.default
    }
}
