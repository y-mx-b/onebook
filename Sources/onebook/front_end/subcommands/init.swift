import Foundation
import ArgumentParser

fileprivate func createConfigPrompt() {
    print("Create configuration file?")
    print("Y/N?", terminator: " ")
    let input = readLine()
    switch input!.uppercased() {
    case "Y", "YES":
        createConfig()
    case "N", "NO":
        print("Aborting.")
    default:
        print("ERROR: INVALID INPUT")
        createConfigPrompt()
    }
}

func createBookmarksDirectoryPrompt() {
    let permission = readLine()

    switch permission!.uppercased() {
    case "Y", "YES":
        print("Creating bookmarks directory...")
        createBookmarksDirectory()
    case "N", "NO":
        print("Terminating...")
    default:
        print("ERROR: INVALID INPUT")
        print("Create bookmarks directory?")
        print("Y/N?:", terminator: " ")
        createBookmarksDirectoryPrompt()
    }
}

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
            // TODO remove hard-coded bookmarks path
            // TODO move prompts (front-end) and checks (back-end) to separate function

            checkForBookmarksDirectory()
            if checkForConfigFile().0 {
                print("Configuration file found: \(checkForConfigFile().1)")
            } else {
                print("Configuration file not detected.")
                createConfigPrompt()
            }
        }
    }
}
