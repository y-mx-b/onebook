import Foundation
import ArgumentParser

fileprivate func createNewItemPrompt() -> Bool? {
    print("(Y/N) : ", terminator: "")
    let response = readLine()
    switch response {
    case "Y", "y":
        return true
    case "N", "n":
        return false
    default:
        print("\nInvalid response.\n")
        return createNewItemPrompt()
    }
}

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
            let preferences: Preferences = Preferences()

            print("Initializing onebook...")
            // RUN CHECKS
            let im = InitManager()

            if !im.checkForConfigFile(preferences.configPath) {
                print("Configuration file not found.")
                print("Create new configuration file?")
                let response = createNewItemPrompt()
                if response! {
                    print("Yes.")
                    print()
                } else {
                    print("No.")
                    print()
                }
            }

            if !im.checkForStorageDirectory(preferences.storageDirectory) {
                print("Storage directory not found.")
                print("Create new storage directory?")
                let response = createNewItemPrompt()
                if response! {
                    print("Yes.")
                    print()
                } else {
                    print("No.")
                    print()
                }
            }
        }
    }
}
