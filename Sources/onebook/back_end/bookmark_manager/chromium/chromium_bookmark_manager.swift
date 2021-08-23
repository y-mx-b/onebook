import Foundation

extension BookmarkManager {
        public struct ChromiumBookmarkManager {
            public func getBookmarks(from bookmarksFilePath: URL) -> String? {
                do {
                    let contents = try String(contentsOf: bookmarksFilePath, encoding: .utf8)
                    return contents
                } catch {
                    return nil
                }
            }
            public func parseBookmarks(_ bookmarksDump: String?) -> ChromiumBookmarks? {
                if bookmarksDump == nil { return nil }

                let bookmarkData = bookmarksDump!.data(using: .utf8)
                let decoder = JSONDecoder()
                let data = try! decoder.decode(ChromiumBookmarks.self, from: bookmarkData!)
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
                        data_added = \(bookmark.date_added)
                        guid = \(bookmark.guid)
                        """.utf8)
                        fileManager.createFile(atPath: "\(favoritesPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
                    }

                    for bookmark in syncedArray {
                        let bookmarkData = Data("""
                        url =  \(bookmark.url)
                        data_added = \(bookmark.date_added)
                        guid =  \(bookmark.guid)
                        """.utf8)
                        fileManager.createFile(atPath: "\(syncedPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
                    }

                    for folder in otherArray {
                        for bookmark in folder.children {
                            let bookmarkData = Data("""
                            url = \(bookmark.url)
                            data_added = \(bookmark.date_added)
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
