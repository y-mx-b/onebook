import Foundation

// TODO implement chromium bookmark data storage
// 1. Parse bookmark data (implemented)
// 2. Iterate through folders and create them
//     - Bookmarks Bar --> Favorites
//     - Other
//         - Iterate through children array (folder names)
//     - Mobile (Synced)
// 3. Iterate through children items in each folder
// 4. Create each file (bookmark name)
// 5. Store data in TOML (simple key: value pairs)
//     - URL: <url>
//     - DATE: <date>
//     - GUID: <guid>
//     - ID: <id>

func storeChromiumBookmarksData(_ bookmarksData: ChromiumBookmarks, storeAt bookmarksPath: URL) {
    func createFolders() {
        let folderCreator = FileManager.default
        let bookmarksPath = "\(NSHomeDirectory())/.bookmarks/"
        let favoritesPath = "\(bookmarksPath)Favorites"
        let syncedPath = "\(bookmarksPath)Synced"
        let otherArray = bookmarksData.roots.other.children

        var folderArray = [favoritesPath, syncedPath]

        for folder in otherArray {
            folderArray.append("\(bookmarksPath)\(folder.name)")
        }
        for folder in folderArray {
            try! folderCreator.createDirectory(atPath: folder, withIntermediateDirectories: false)
        }
    }
    func createFiles() {
        let bookmarkBarArray = bookmarksData.roots.bookmark_bar.children
        for bookmark in bookmarkBarArray {
            print(bookmark.name)
        }
        let syncedArray = bookmarksData.roots.synced.children
        for bookmark in syncedArray {
            print(bookmark.name)
        }
        let otherArray = bookmarksData.roots.other.children
        for folder in otherArray {
            for bookmark in folder.children {
                print(bookmark.name)
            }
        }
    }
    createFolders()
}
