import Foundation

func importBookmarkData(from browser: String) {
    switch browser {
    case "chromium":
        let bookmarksPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks") as URL
        let bookmarksData = parseChromiumBookmarks(getChromiumBookmarks(from: bookmarksPath))
        storeChromiumBookmarksData(bookmarksData, storeAt: bookmarksPath)
    case "chrome":
        print("Chrome")
    case "safari":
        print("Safari")
    case "firefox":
        print("Firefox")
    case "qutebrowser":
        print("Qutebrowser")
    default:
        print("Invalid browser")
    }
}
