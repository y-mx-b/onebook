import Foundation

extension BookmarkManager {
    func createBookmark(_ bookmarkPath: String, siteURL: String) throws -> Bool {
        let fm = FileManager.default
        let data = siteURL.data(using: .utf8)
        var status = false
        if !fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil) {
            let pathArray = bookmarkPath.components(separatedBy: "/").dropLast()
            try fm.createDirectory(atPath: pathArray.joined(separator: "/"),
                               withIntermediateDirectories: true,
                               attributes: nil)
            status = fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil)
        }
        return status
    }

    func edit(_ bookmarkPath: String) -> Bool {
        return false
    }

    func removeBookmark(_ bookmarkPath: String) throws -> Bool {
        let fm = FileManager.default
        try fm.removeItem(atPath: bookmarkPath)
        return false
    }

    func renameBookmark(_ originalPath: String?, to newPath: String?) {
    }
}
