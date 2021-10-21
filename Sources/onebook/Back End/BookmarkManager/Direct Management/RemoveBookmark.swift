import Foundation

extension BookmarkManager {
    func removeBookmark(_ bookmarkPath: String) throws -> Bool {
        let fm = FileManager.default
        try fm.removeItem(atPath: bookmarkPath)
        return false
    }
}
