import Foundation
import ArgumentParser

fileprivate func prompt() -> Bool {
    print("(Y/N) : ", terminator: "")
    let response = readLine()
    switch response {
    case "Y", "y":
        return true
    case "N", "n":
        return false
    default:
        print("\nInvalid response.\n")
        return prompt()
    }
}

extension InitErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .noPreferences(path):
            return """
                Preferences file not found.
                Expected preferences file at: \(path)
                """
        case let .noConfig(path):
            return """
                Configuration file not found.
                Expected configuration file at: \(path)
                """
        case let .noStorage(path):
            return """
                Storage directory not found.
                Expected storage directory at : \(path)
                """
        }
    }
}

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
            let im = InitManager()
            let fm = FileManager.default
            var preferences = Preferences()
            let preferencesPath = preferences.preferencesPath
            // TODO: RUN CHECKS
            //     TODO: PREFERENCES
            //         if exists -> load preferences
            //         else -> create
            //     TODO: CONFIG
            //         if exists -> overwrite? -> yes, no
            //     TODO: STORAGE
            //         if not exist -> create

            // PREFERENCE CHECKS
            do {
                if try im.checkForPreferencesFile() {
                    print("Preferences file found.")
                    let preferencesData = fm.contents(atPath: preferencesPath)
                    preferences = try! PropertyListDecoder().decode(Preferences.self, from: preferencesData!)
                } else {
                    print("Preferences file was empty.")
                    print("Overwriting preferences file...")
                    _ = im.createPreferencesFile()
                }
            } catch {
                print(error.localizedDescription)
                print("Creating preferences file...")
                _ = im.createPreferencesFile()
            }

            print()

            // CONFIG CHECKS
            if preferences.configState {
                do {
                    if try im.checkForConfigFile(preferences.configPath) {
                        print("Configuration file found. Overwrite?")
                        if prompt() {
                            _ = im.createConfigFile(preferences.configPath)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    print("Create configuration file?")
                    if prompt() {
                        _ = im.createConfigFile(preferences.configPath)
                    } else {
                        print("Disable configuration file?")
                        if prompt() { try! ConfigManager().set("config", value: "off") }
                    }
                }
            }

            print()

            // STORAGE CHECKS
            do {
                _ = try im.checkForStorageDirectory(preferences.storageDirectory)
                print("Storage directory found.")
            } catch {
                print(error.localizedDescription)
                print("Creating storage directory...")
                _ = im.createStorageDirectory(preferences.storageDirectory)
            }
        }
    }
}
