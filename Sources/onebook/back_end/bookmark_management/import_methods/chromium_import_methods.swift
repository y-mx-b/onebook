import Foundation
import BookmarkParser

extension ChromiumBookmarkManager {
    public func storeBookmarks(_ bookmarksData: ChromiumBookmarks?, storeAt storageDirectory: String) {
        let fileManager = FileManager.default

        let bookmarkBarArray = bookmarksData!.roots.bookmark_bar.children
        let syncedArray = bookmarksData!.roots.synced.children
        let otherArray = bookmarksData!.roots.other.children
        let masterArray = [(bookmarkBarArray, "Bookmarks Bar"), (syncedArray, "Synced"), (otherArray, "")]

        func createFolder(at folderPath: String) throws {
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true)
        }
        func createFile(at filePath: String, bookmark: ChromiumChildren) {
            let bookmarkData = Data("""
                                    url = \(bookmark.url!)
                                    date_added = \(bookmark.date_added)
                                    guid = \(bookmark.guid)
                                    """.utf8)
            fileManager.createFile(atPath: filePath, contents: bookmarkData)
        }

        func recursiveStorage(_ bookmarkArray: [ChromiumChildren]?, at basePath: String) {
            var folderPath: String

            for item in bookmarkArray! {
                folderPath = basePath + "/"
                if item.url != nil {
                    createFile(at: folderPath + item.name, bookmark: item)
                } else {
                    folderPath = folderPath + item.name
                    do { try createFolder(at: folderPath)  } catch { print(folderPath)  }
                    recursiveStorage(item.children, at: folderPath)
                }
            }

        }

        for item in masterArray {
            recursiveStorage(item.0, at: (storageDirectory + item.1))
        }
    }
}
