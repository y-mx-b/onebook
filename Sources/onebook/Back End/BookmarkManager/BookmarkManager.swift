import Foundation
import BookmarkParser

struct BookmarkManager {
    var browser: Browser?
    var bookmarkFilePath: String?
    var storageDirectory: String = try! ConfigManager().loadPreferences().storageDirectory

    init() {
        browser = nil
        bookmarkFilePath = nil
    }

    init(browser: Browser) {
        self.browser = browser
        bookmarkFilePath = bookmarkPaths[browser]
    }

    init(bookmarkFilePath: String) {
        browser = nil
        self.bookmarkFilePath = bookmarkFilePath
    }

    func getFullPath(_ bookmarkFilePath: String) -> String {
        return storageDirectory + bookmarkFilePath
    }
}
