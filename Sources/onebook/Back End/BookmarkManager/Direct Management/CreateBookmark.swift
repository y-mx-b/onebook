import Foundation

extension BookmarkManager {
    func createBookmark(_ bookmarkPath: String, siteURL: String) -> Bool {
        let fm = FileManager.default
        let data = siteURL.data(using: .utf8)
        return fm.createFile(atPath: bookmarkPath, contents: data, attributes: nil)
    }
}
