import ArgumentParser

extension Onebook {
    struct Remove: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Remove a bookmark.")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The name and location of the bookmark you'll be removing.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var bookmarkPath: String = ""

        mutating func run() {
        }
    }
}
