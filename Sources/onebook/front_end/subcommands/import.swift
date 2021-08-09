import Foundation
import ArgumentParser

extension Onebook {
    struct Import: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Import bookmarks from a browser.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The browser to import bookmarks from.",
                discussion: "If no browser is provided, the default browser will be used.",
                valueName: "browser-name"))
            var browser: String

        mutating func run() {
            func importBookmarkData(from browser: String) {
                switch browser {
                case "chromium":
                    let chromiumBookmarksPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks") as URL
                    let bookmarkData = parseChromiumBookmarks(getChromiumBookmarks(from: chromiumBookmarksPath))
                    storeChromiumBookmarksData(bookmarkData, storeAt: chromiumBookmarksPath)
                default:
                    print("Invalid browser")
                }
            }
            importBookmarkData(from: browser)
        }
    }
}
