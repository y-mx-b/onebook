import Foundation

fileprivate let bookmarkFileArray: [String: String] = [
    "CHROMIUM": "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks",
    "CHROME": "",
    "SAFARI": "\(NSHomeDirectory())/Library/Application Support/Safari/Bookmarks.plist",
    "FIREFOX": "",
    "QUTEBROWSER": ""
]

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

    public func getBookmarks() -> ChromiumBookmarks? {
        let browser = BrowserEnum(rawValue: browserName!.uppercased()) ?? .none

        switch browser {
        case .chromium:
            let bookmarkManager = ChromiumBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            let bookmarksDump = bookmarkManager.getChromiumBookmarks(from: bookmarksURL)
            if let bookmarks = bookmarkManager.parseChromiumBookmarks(bookmarksDump) {
                return bookmarks
            } else {
                return nil
            }
            // storeChromiumBookmarksData(bookmarksData.1!, storeAt: bookmarksDirectoryURL)
        case .chrome:
            print(browserName)
            return nil
        case .safari:
            let bookmarksPath = URL(fileURLWithPath: "\(NSHomeDirectory())/Library/Safari/Bookmarks.plist")
            let bookmarksData = parseSafariBookmarks(getSafariBookmarks(from: bookmarksPath))
            // let bookmarksDump = getSafariBookmarks(from: bookmarksPath)
            storeSafariBookmarks(bookmarksData, storeAt: bookmarksPath)
            return nil
        case .firefox:
            print(browserName)
            return nil
        case .qutebrowser:
            print(browserName)
            return nil
        default:
            print(browserName)
            return nil
        }
    }

    public func storeBookmarks(_ bookmarks: ChromiumBookmarks) {
        let browser = BrowserEnum(rawValue: browserName!.uppercased()) ?? .none
        let storageDirectoryURL = URL(fileURLWithPath: storageDirectory, isDirectory: true)

        switch browser {
        case .chromium:
        let bookmarkManager = ChromiumBookmarkManager()
        bookmarkManager.storeChromiumBookmarksData(bookmarks, storeAt: storageDirectory)
        case .chrome:
        print(browserName)
        case .safari:
        print(browserName)
        case .firefox:
        print(browserName)
        case .qutebrowser:
        print(browserName)
        default:
        print(browserName)
        }
    }
}
