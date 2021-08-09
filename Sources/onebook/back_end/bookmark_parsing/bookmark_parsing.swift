import Foundation

func getBookmarkData(from browser: String) -> String? {
    var bookmarkData: String?
    switch browser {
    case "chromium":
        bookmarkData = getChromiumBookmarks()
    default:
        print("Browser not supported")
    }
    return bookmarkData == nil ? nil : bookmarkData
}
