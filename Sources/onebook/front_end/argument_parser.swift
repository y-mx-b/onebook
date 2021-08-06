import ArgumentParser

struct Onebook: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "A universal bookmark management utility.",
            subcommands: [Parse.self])

    struct Options: ParsableArguments {
        // type with properties that will be shared across multiple subcommands
    }
}


extension Onebook {
    struct Parse: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Parse JSON.")

        @OptionGroup var options: Onebook.Options

        @Argument var browser: String

        mutating func run() {
            let bookmarkData: String? = getBookmarkData(browser: browser)
            parseChromiumBookmarks(chromiumBookmarkData: bookmarkData)
        }
    }
}
