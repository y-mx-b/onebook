import Foundation
import ArgumentParser
import BookmarkParser

extension Onebook {
    struct Create: ParsableCommand {
        static var configuration = CommandConfiguration(
                                    abstract: "Create a new bookmark.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The name and location of the bookmark you'll be adding.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var bookmarkPath: String = ""
        @Argument(
            help: ArgumentHelp(
                "The URL of the site to be stored in the bookmark.",
                valueName: "website-url"))
        var siteURL: String = ""

        mutating func run() {
        }
    }
}
