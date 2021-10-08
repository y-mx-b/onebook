import Foundation
import ArgumentParser

fileprivate func prompt() -> Bool? {
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

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
            let preferences: Preferences = Preferences()

            print("Initializing onebook...")
            print()

            // RUN CHECKS
            let im = InitManager()

            // PREFERNCES FILE
            if !im.checkForPreferencesFile() {
                print("Preferences file not found.")
                print("Creating new preferences file...")
                if im.createPreferencesFile() {
                    print("Operation successful.")
                } else {
                    print("Operation failed.")
                }
            } else {
                print("Preferences file located.")
                print("Overwrite preferences file?")
                if prompt()! {
                    try! FileManager.default.removeItem(atPath: preferences.preferencesPath)
                    if im.createPreferencesFile() {
                        print("Operation successful.")
                    } else {
                        print("Operation failed.")
                    }
                } else {
                    print("Aborting...")
                }
            }
            print()

            // CONFIG FILE
            if !im.checkForConfigFile(preferences.configPath) {
                print("Configuration file not found.")
                print("Create new configuration file?")
                if prompt()! {
                    print("Creating cofig file...")
                    if im.createConfigFile(preferences.configPath) {
                        print("Successful.")
                    } else {
                        print("Operation failed.")
                    }
                    print()
                } else {
                    print("Would you like to disable configuration file reading?")
                    if prompt()! {
                        print("Disabling configuration file...")
                        try! ConfigManager().set("config", value: "off")
                    }
                }
            } else {
                print("Configuration file exists.")
                print("Overwrite configuration file?")
                if prompt()! {
                    try! FileManager.default.removeItem(atPath: preferences.configPath)
                    if im.createConfigFile(preferences.configPath) {
                        print("Operation successful.")
                    } else {
                        print("An error has occurred.")
                    }
                } else {
                    print("Aborting...")
                }
            }
            print()

            // STORAGE DIRECTORY
            if !im.checkForStorageDirectory(preferences.storageDirectory) {
                print("Storage directory not found.")
                print("Creating new storage directory...")
                _ = im.createStorageDirectory(preferences.storageDirectory)
            } else {
                print("Storage directory exists.")
                print("Aborting.")
            }
        }
    }
}
