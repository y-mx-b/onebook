import ArgumentParser

extension Onebook {
    struct Import: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Import bookmarks from a browser (WIP).")
        @OptionGroup var options: Onebook.Options
        @Argument(
            help: ArgumentHelp(
                "The browser to import bookmarks from.",
                discussion: "If no browser is provided, the default browser will be used.",
                valueName: "browser-name"
            )
        )
        // TODO: use the value set in preferences
        var browser: String = "Chrome"

        mutating func run() {
        }
    }
}
