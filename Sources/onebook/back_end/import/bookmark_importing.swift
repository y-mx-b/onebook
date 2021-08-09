import Foundation

func importBookmarkData(from browser: String) {
    print(browser.uppercased())
    switch browser.uppercased() {
    case "CHROMIUM":
        let bookmarksPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks") as URL
        let bookmarksData = parseChromiumBookmarks(getChromiumBookmarks(from: bookmarksPath))
        storeChromiumBookmarksData(bookmarksData, storeAt: bookmarksPath)
    case "CHROME":
        print("Chrome")
    case "SAFARI":
        print("Safari")
    case "FIREFOX":
        print("Firefox")
    case "QUTEBROWSER":
        print("Qutebrowser")
    default:
        print("Invalid browser")
    }
}
