import Foundation
import ArgumentParser

extension Onebook {
    struct Set: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Set preferences.")

        @OptionGroup var options: Onebook.Options

        @Argument(
            help: ArgumentHelp(
                "The preference to set.",
                valueName: "preference-key"))
            var preferenceKey: String

            @Argument(
                help: ArgumentHelp(
                    "The new value to set the preference to.",
                    valueName: "new-value"))
            var newValue: String

        mutating func run() {
            let cm = ConfigManager()
            do {
                try cm.set(preferenceKey, value: newValue)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
