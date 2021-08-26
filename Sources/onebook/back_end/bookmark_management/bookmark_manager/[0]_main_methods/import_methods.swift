import Foundation

#if os(macOS)
fileprivate let bookmarkFileArray: [String: String] = [
    "CHROMIUM": "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks",
    "CHROME": "\(NSHomeDirectory())/Library/Application Support/Google/Chrome/Default/Bookmarks",
    "SAFARI": "\(NSHomeDirectory())/Library/Safari/Bookmarks.plist",
    "BRAVE": "\(NSHomeDirectory())/Library/Application Support/BraveSoftware/Brave-Browser/Default/Bookmarks",
    "FIREFOX": "",
    "QUTEBROWSER": ""
]
#elseif os(Linux)
fileprivate let bookmarkFileArray: [String: String] = [
    "CHROMIUM": "\(NSHomeDirectory())/.config/chromium/Default/Bookmarks",
    "CHROME": "\(NSHomeDirectory())/.config/google-chrome/Default/Bookmarks",
    "BRAVE": "\(NSHomeDirectory())/.config/BraveSoftware/Brave-Browser/Default/Bookmarks",
    "FIREFOX": "",
    "QUTEBROWSER": ""
]
#endif

fileprivate enum BrowserEnum: String {
    case chromium = "CHROMIUM"
    case chrome = "CHROME"
    #if os(macOS)
    case safari = "SAFARI"
    #endif
    case brave = "BRAVE"
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
        case .chromium, .chrome, .brave:
            let bookmarkManager = ChromiumBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            return bookmarkManager.getBookmarks(from: bookmarksURL)
        #if os(macOS)
        case .safari:
            let bookmarkManager = SafariBookmarkManager()
            let bookmarksURL = URL(fileURLWithPath: bookmarksFilePath ?? "")
            return bookmarkManager.getBookmarks(from: bookmarksURL)
        #endif
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
        case .chromium, .chrome, .brave:
            let bookmarkManager = ChromiumBookmarkManager()
            let bookmarks = bookmarkManager.parseBookmarks(bookmarksDump)
            bookmarkManager.storeBookmarks(bookmarks!, storeAt: storageDirectory)
        #if os(macOS)
        case .safari:
            let bookmarkManager = SafariBookmarkManager()
            let bookmarks = bookmarkManager.parseBookmarks(bookmarksDump)
            bookmarkManager.storeBookmarks(bookmarks!, storeAt: storageDirectory)
        #endif
        // case .firefox:
        // print(browserName)
        // case .qutebrowser:
        // print(browserName)
        default:
        print(browserName!)
        }
    }
}
