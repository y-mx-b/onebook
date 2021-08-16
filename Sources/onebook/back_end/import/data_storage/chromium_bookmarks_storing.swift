import Foundation

func storeChromiumBookmarksData(_ bookmarksData: ChromiumBookmarks, storeAt bookmarksPath: URL) {
    let fileManager = FileManager.default

    let bookmarkBarArray = bookmarksData.roots.bookmark_bar.children
    let syncedArray = bookmarksData.roots.synced.children
    let otherArray = bookmarksData.roots.other.children

    func createFolders() {
        let bookmarksPath = "\(NSHomeDirectory())/.bookmarks/"
        let favoritesPath = "\(bookmarksPath)Favorites"
        let syncedPath = "\(bookmarksPath)Synced"
        let otherArray = bookmarksData.roots.other.children

        var folderArray = [favoritesPath, syncedPath]

        for folder in otherArray {
            folderArray.append("\(bookmarksPath)\(folder.name)")
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
        let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
        let favoritesPath = "\(bookmarksPath)/Favorites"
        let syncedPath = "\(bookmarksPath)/Synced"

        for bookmark in bookmarkBarArray {
            let bookmarkData = Data("""
            url: \(bookmark.url)
            data_added: \(bookmark.date_added)
            guid: \(bookmark.guid)
            """.utf8)
            fileManager.createFile(atPath: "\(favoritesPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
        }

        for bookmark in syncedArray {
            let bookmarkData = Data("""
            url: \(bookmark.url)
            data_added: \(bookmark.date_added)
            guid: \(bookmark.guid)
            """.utf8)
            fileManager.createFile(atPath: "\(syncedPath)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
        }

        for folder in otherArray {
            for bookmark in folder.children {
            let bookmarkData = Data("""
            url: \(bookmark.url)
            data_added: \(bookmark.date_added)
            guid: \(bookmark.guid)
            """.utf8)
                fileManager.createFile(atPath: "\(bookmarksPath)/\(folder.name)/\(bookmark.name)", contents: bookmarkData, attributes: nil)
            }
        }
    }
    createFolders()
    createFiles()
}
