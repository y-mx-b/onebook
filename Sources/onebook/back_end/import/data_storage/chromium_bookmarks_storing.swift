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
    }
    print(bookmarksData.roots.bookmark_bar)
}
