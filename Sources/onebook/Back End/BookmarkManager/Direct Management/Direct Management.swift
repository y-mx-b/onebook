import Foundation

extension BookmarkManager {
    func createBookmark(_ bookmarkPath: String, siteURL: String) -> Bool {
        let fm = FileManager.default
        let data = siteURL.data(using: .utf8)
        return fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil)
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
