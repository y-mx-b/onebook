import Foundation

#if os(macOS)
fileprivate let bookmarkFileArray: [String: String] = [
    "CHROMIUM": "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks",
    "CHROME": "\(NSHomeDirectory())/Library/Application Support/Google/Chrome/Default/Bookmarks",
    "SAFARI": "\(NSHomeDirectory())/Library/Safari/Bookmarks.plist",
    "FIREFOX": "",
    "QUTEBROWSER": ""
]
#endif

fileprivate enum BrowserEnum: String {
    case chromium = "CHROMIUM"
    case chrome = "CHROME"
    case safari = "SAFARI"
    case firefox = "FIREFOX"
    case qutebrowser = "QUTEBROWSER"
    case none
}

extension BookmarkManager {
    public mutating func setDefaultBookmarksPath() {
        bookmarksFilePath = bookmarkFileArray[browserName!.uppercased()]
    }

    public func getBookmarks() -> Data? {
        let browser = BrowserEnum(rawValue: browserName!.uppercased()) ?? .none

        switch browser {
        case .chromium, .chrome:
            let bookmarkManager = ChromiumBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            return bookmarkManager.getBookmarks(from: bookmarksURL)
        case .safari:
            let bookmarkManager = SafariBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            return bookmarkManager.getBookmarks(from: bookmarksURL)
            return nil
        // case .firefox:
        //     print(browserName)
        //     return nil
        // case .qutebrowser:
        //     print(browserName)
        //     return nil
        default:
            // print(browserName)
            return nil
        }
    }

    public func storeBookmarks(_ bookmarksDump: Data?) {
        let browser = BrowserEnum(rawValue: browserName!.uppercased()) ?? .none
        // let storageDirectoryURL = URL(fileURLWithPath: storageDirectory, isDirectory: true)

        switch browser {
        case .chromium, .chrome:
        let bookmarkManager = ChromiumBookmarkManager()
        let bookmarks = bookmarkManager.parseBookmarks(bookmarksDump)
        bookmarkManager.storeBookmarks(bookmarks!, storeAt: storageDirectory)
        case .safari:
        let bookmarkManager = SafariBookmarkManager()
        let bookmarks = bookmarkManager.parseBookmarks(bookmarksDump)
        bookmarkManager.storeBookmarks(bookmarks!, storeAt: storageDirectory)
        // case .firefox:
        // print(browserName)
        // case .qutebrowser:
        // print(browserName)
        default:
        print(browserName!)
        }
    }
}
