import ArgumentParser

extension Onebook {
    struct Edit: ParsableCommand {
        static var configuration = CommandConfiguration(
                                    abstract: "Edit a bookmark (WIP).")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The name and location of the bookmark you'll be editing.",
                discussion: "Format as /folder_one/folder_two/bookmark_name",
                valueName: "bookmark-path"))
        var bookmarkPath: String = ""

        mutating func run() {
        }
    }
}
