import ArgumentParser

extension Onebook {
    struct Rename: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Remove a bookmark.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The name and location of the bookmark you'll be renaming.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var oldBookmarkPath: String = ""
        @Argument(
            help: ArgumentHelp(
                "The new name and location of the bookmark.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var newBookmarkPath: String = ""

        mutating func run() {
            do {
                let bm = BookmarkManager()
                try bm.renameBookmark(oldBookmarkPath, to: newBookmarkPath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
