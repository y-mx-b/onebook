import Foundation
import ArgumentParser

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
        }
    }
}
