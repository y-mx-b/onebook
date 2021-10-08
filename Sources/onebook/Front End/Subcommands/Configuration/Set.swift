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
                print("Operation successful.")
            } catch ConfigError.invalidKey {
                print("Operation failed.")
                print("An invalid setting was specified.")
            } catch ConfigError.InvalidValue.notBool {
                print("Operation failed.")
                print("An invalid value was specified. Please use on/off.")
            } catch ConfigError.InvalidValue.invalidBrowser {
                print("Operation failed.")
                print("An invalid browser was specified.")
            } catch ConfigError.InvalidValue.invalidFormatType {
                print("Operation failed.")
                print("An invalid format type was specified.")
            } catch ConfigError.InvalidValue.generic {
                print("Operation failed.")
                print("An invalid value was specified.")
            } catch {
                print("Operation failed.")
                print("An unexpected error has occured.")
            }
        }
    }
}
