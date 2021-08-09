import Foundation

func getBookmarkData(from browser: String) -> String? {
    var bookmarkData: String?
    switch browser {
    case "chromium":
        let chromiumBookmarksPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks") as URL
        bookmarkData = getChromiumBookmarks(from: chromiumBookmarksPath)
    default:
        print("Invalid browser")
    }
    return bookmarkData == nil ? nil : bookmarkData
}
