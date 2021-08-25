import Foundation

protocol BrowserBookmarkManager {
    associatedtype BookmarkType
    func getBookmarks(from bookmarksFilePath: URL) -> Data?
    func parseBookmarks(_ bookmarksDump: Data?) -> BookmarkType
    func storeBookmarks(_ bookmarksData: BookmarkType, storeAt storageDirectory: String)
}
