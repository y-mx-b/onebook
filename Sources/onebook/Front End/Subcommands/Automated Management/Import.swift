import Foundation
import ArgumentParser
import BookmarkParser

extension Onebook {
    struct Import: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Import bookmarks from a browser.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The browser to import bookmarks from.",
                discussion: "If no browser is provided, the default browser will be used.",
                valueName: "browser-name"))
            var browser: String = "Chrome"

        mutating func run() {
            var bookmarkManager = BookmarkManager(browserName: browser)
            if bookmarkManager.bookmarksFilePath == nil { bookmarkManager.setDefaultBookmarksPath() }
            let bookmarks = bookmarkManager.getBookmarks()
            bookmarkManager.storeBookmarks(bookmarks)
        }
    }
}
