import Foundation

// TODO implement chromium bookmark data storage
// 1. DONE Parse bookmark data (implemented)
// 2. DONE Iterate through folders and create them
//     - Bookmarks Bar --> Favorites
//     - Other
//         - Iterate through children array (folder names)
//     - Mobile (Synced)
// 3. TODO Iterate through children items in each folder
// 4. TODO Create each file (bookmark name)
// 5. TODO Store data in TOML (simple key: value pairs)
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
            do {
                try folderCreator.createDirectory(atPath: folder, withIntermediateDirectories: false)
            } catch {
                // print("Folder \(folder) already exists. Skipping step.")
            }
        }
    }
    func createFiles() {
        let fileCreator = FileManager.default
        let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
        let favoritesPath = "\(bookmarksPath)/Favorites"
        let syncedPath = "\(bookmarksPath)/Synced"

        let bookmarkBarArray = bookmarksData.roots.bookmark_bar.children

        for bookmark in bookmarkBarArray {
            print("\(favoritesPath)/\(bookmark.name)")
            print(fileCreator.createFile(atPath: "\(favoritesPath)/\(bookmark.name)", contents: nil, attributes: nil))
            // print(bookmark.name)
        }

        // let syncedArray = bookmarksData.roots.synced.children

        // for bookmark in syncedArray {
        //     print(bookmark.name)
        // }

        // let otherArray = bookmarksData.roots.other.children

        // for folder in otherArray {
        //     for bookmark in folder.children {
        //         print(bookmark.name)
        //     }
        // }
    }
    createFolders()
    createFiles()
}
