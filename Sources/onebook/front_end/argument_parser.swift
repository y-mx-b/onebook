import ArgumentParser

struct Onebook: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "A universal bookmark management utility.",
            subcommands: [Import.self, Init.self, Create.self, Remove.self])

    struct Options: ParsableArguments {
        // type with properties that will be shared across multiple subcommands
    }
}
