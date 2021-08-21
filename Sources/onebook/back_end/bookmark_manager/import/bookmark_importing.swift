import Foundation

fileprivate let bookmarkFileArray: [String: String] = [
    "CHROMIUM": "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks",
    "CHROME": "",
    "SAFARI": "\(NSHomeDirectory())/Library/Application Support/Safari/Bookmarks.plist",
    "FIREFOX": "",
    "QUTEBROWSER": ""
]

extension BookmarkManager {
    mutating func setDefaultBookmarksPath() {
        bookmarksFilePath = bookmarkFileArray[browserName!]
    }

    func importBookmarkData() {
        let bookmarksDirectoryURL = URL(fileURLWithPath: storageDirectory, isDirectory: true)
        switch browserName!.uppercased() {
        case "CHROMIUM":
            let bookmarkManager = ChromiumBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            let bookmarksData = bookmarkManager.parseChromiumBookmarks(bookmarkManager.getChromiumBookmarks(from: bookmarksURL))
            // storeChromiumBookmarksData(bookmarksData.1!, storeAt: bookmarksDirectoryURL)
        case "CHROME":
            print(browserName)
        case "SAFARI":
            let bookmarksPath = URL(fileURLWithPath: "\(NSHomeDirectory())/Library/Safari/Bookmarks.plist")
            let bookmarksData = parseSafariBookmarks(getSafariBookmarks(from: bookmarksPath))
            storeSafariBookmarks(bookmarksData, storeAt: bookmarksPath)
        case "FIREFOX":
            print(browserName)
        case "QUTEBROWSER":
            print(browserName)
        default:
            print(browserName)
        }
    }
}
