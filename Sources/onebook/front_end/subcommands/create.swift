import Foundation
import ArgumentParser



extension Onebook {
    struct Create: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Create a new bookmark.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The name and location of the bookmark you'll be adding.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var bookmark: String = ""

        mutating func run() {
            let bookmarkManager = BookmarkManager()
            bookmarkManager.create(nil, siteURL: nil)
        }
    }
}
