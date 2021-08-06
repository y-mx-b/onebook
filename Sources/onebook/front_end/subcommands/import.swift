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
            let bookmarkData: String? = getBookmarkData(browser: browser)
            parseChromiumBookmarks(chromiumBookmarkData: bookmarkData)
        }
    }
}
