import Foundation

extension BookmarkManager {
        public struct ChromiumBookmarkManager {
            public func getBookmarks(from bookmarksFilePath: URL) -> Data? {
                do {
                    let contents = try Data(contentsOf: bookmarksFilePath)
                    return contents
                } catch {
                    return nil
                }
            }
            public func parseBookmarks(_ bookmarksDump: Data?) -> ChromiumBookmarks? {
                if bookmarksDump == nil { return nil }

                let decoder = JSONDecoder()
                let data = try! decoder.decode(ChromiumBookmarks.self, from: bookmarksDump!)
                return data
            }
            public func storeBookmarks(_ bookmarksData: ChromiumBookmarks, storeAt storageDirectory: String) {
                let fileManager = FileManager.default

                let bookmarkBarArray = bookmarksData.roots.bookmark_bar.children
                let syncedArray = bookmarksData.roots.synced.children
                let otherArray = bookmarksData.roots.other.children

                let favoritesPath = "\(storageDirectory)/Favorites"
                let syncedPath = "\(storageDirectory)/Synced"

                func createFolders() {
                    let otherArray = bookmarksData.roots.other.children

                    var folderArray = [favoritesPath, syncedPath]

                    for folder in otherArray {
                        folderArray.append("\(storageDirectory)\(folder.name)")
                    }
                    for folder in folderArray {
                        do {
                            try fileManager.createDirectory(atPath: folder, withIntermediateDirectories: false)
                        } catch {
                            // print("Folder \(folder) already exists. Skipping step.")
                        }
                    }
                }

                func createFiles() {
                    for bookmark in bookmarkBarArray {
                        let bookmarkData = Data("""
                        url = \(bookmark.url)
                        date_added = \(bookmark.date_added)
                        guid = \(bookmark.guid)
                        """.utf8)
                        fileManager.createFile(atPath: "\(favoritesPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
                    }

                    for bookmark in syncedArray {
                        let bookmarkData = Data("""
                        url =  \(bookmark.url)
                        date_added = \(bookmark.date_added)
                        guid =  \(bookmark.guid)
                        """.utf8)
                        fileManager.createFile(atPath: "\(syncedPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
                    }

                    for folder in otherArray {
                        for bookmark in folder.children {
                            let bookmarkData = Data("""
                            url = \(bookmark.url)
                            date_added = \(bookmark.date_added)
                            guid = \(bookmark.guid)
                            """.utf8)
                            fileManager.createFile(atPath: "\(storageDirectory)/\(folder.name)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
                        }
                    }
                }
                createFolders()
                createFiles()
            }
    }
}
