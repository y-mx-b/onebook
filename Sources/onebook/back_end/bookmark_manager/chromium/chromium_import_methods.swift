import Foundation

extension BookmarkManager {
    public struct ChromiumBookmarkManager {
        public func getBookmarks(from bookmarksFilePath: URL) -> Data? {
            // TODO change function to a throwing one, make things safer
            do {
                let contents = try Data(contentsOf: bookmarksFilePath)
                return contents
            } catch {
                return nil
            }
        }
        public func parseBookmarks(_ bookmarksDump: Data?) -> ChromiumBookmarks? {
            // TODO change function to a throwing one, make things safer
            if bookmarksDump == nil { return nil }

            let decoder = JSONDecoder()
            let data = try! decoder.decode(ChromiumBookmarks.self, from: bookmarksDump!)
            return data
        }
        public func storeBookmarks(_ bookmarksData: ChromiumBookmarks, storeAt storageDirectory: String) {
            // TODO: clean it up a bit, make it safer, perhaps make it portable to Brave?
            let fileManager = FileManager.default

            let bookmarkBarArray = bookmarksData.roots.bookmark_bar.children
            let syncedArray = bookmarksData.roots.synced.children
            let otherArray = bookmarksData.roots.other.children
            let masterArray = [bookmarkBarArray, syncedArray, otherArray]

            let favoritesPath = "\(storageDirectory)/Favorites"
            let syncedPath = "\(storageDirectory)/Synced"

            func createFolder(at folderPath: String) throws {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: false)
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
                var folderPath: String;

                for item in bookmarkArray! {
                folderPath = basePath + "/"
                    if item.url != nil {
                        createFile(at: folderPath + item.name, bookmark: item)
                    } else {
                        folderPath = folderPath + item.name + "/"
                        do { try createFolder(at: folderPath) } catch {print(error)}
                        recursiveStorage(item.children, at: folderPath)
                    }
                }
            }

            for bookmarkArray in masterArray {
                recursiveStorage(bookmarkArray, at: storageDirectory)
            }
        }
    }
}
