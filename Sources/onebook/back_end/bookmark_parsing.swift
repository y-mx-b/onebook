import Foundation

func getBookmarkData(browser: String) -> String? {
    var bookmarkData: String?
    switch(browser) {
        case "chromium":
            bookmarkData = getChromiumBookmarks()
        default:
            print("Browser not supported")
    }

    if (bookmarkData == nil) {
        return nil
    } else {
        return bookmarkData
    }
}
