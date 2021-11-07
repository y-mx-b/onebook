import Foundation

extension BookmarkManager {
    func createBookmark(at bookmarkPath: String, siteURL: String) throws {
        let flm = FileManager.default
        let data = siteURL.data(using: .utf8)
        if !flm.createFile(atPath: bookmarkPath, contents: data, attributes: nil) {
            let pathArray = bookmarkPath.components(separatedBy: "/").dropLast()
            try flm.createDirectory(atPath: pathArray.joined(separator: "/"),
                               withIntermediateDirectories: true,
                               attributes: nil)
            flm.createFile(atPath: bookmarkPath, contents: data, attributes: nil)
        }
    }

    func edit(_ bookmarkPath: String) {
    }

    func removeBookmark(_ bookmarkPath: String) throws {
        let flm = FileManager.default
        try flm.removeItem(atPath: bookmarkPath)
    }

    func renameBookmark(_ originalPath: String?, to newPath: String?) {
        let flm = FileManager.default
    }
}
