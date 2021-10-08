import Foundation
import ArgumentParser

extension ConfigError: LocalizedError {
    var errorDescription: String? {
        switch self {
        // KEY
        case .invalidKey(let key):
            return """
                    Invalid key was supplied: "\(key)".
                    """
        // VALUES
        case .notBool(let bool):
            return """
                    Invalid value was supplied: "\(bool)".
                    Expected: "on" or "off".
                    """
        case .invalidBrowser(let browser):
            return """
                    Invalid value was supplied: "\(browser)" is not a valid browser.
                    """
        case .invalidFormatType(let format):
            return """
                    Invalid value was supplied: "\(format)" is not a valid format.
                    """
        case .generic(let value):
            return """
                    Invalid value was supplied: "\(value)".
                    """
        }
    }
}

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
