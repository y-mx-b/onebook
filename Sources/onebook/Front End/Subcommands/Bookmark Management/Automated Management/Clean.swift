import ArgumentParser

extension Onebook {
    struct Clean: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Remove empty folders (WIP).")
        @OptionGroup var options: Onebook.Options

        mutating func run() {
        }
    }
}
