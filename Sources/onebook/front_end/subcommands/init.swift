import Foundation
import ArgumentParser

func createBookmarksDirectory() {
    let dir = FileManager.default
    let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
    do {
    try dir.createDirectory(atPath: bookmarksPath, withIntermediateDirectories: false, attributes: nil)
    } catch {
        print("ERROR: FAILED TO CREATE BOOKMARKS DIRECTORY")
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
            let dir = FileManager.default
            let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
            var objCTrue: ObjCBool = true
            if dir.fileExists(atPath: bookmarksPath, isDirectory: &objCTrue) {
                print("Bookmarks directory found: \(bookmarksPath)")
            } else {
                print("Bookmarks directory not detected.")
                print("Create bookmarks directory?")
                print("Y/N?:", terminator: " ")
                createBookmarksDirectoryPrompt()
            }
            if checkForConfigFile().0 {
                print("Configuration file found: \(checkForConfigFile().1)")
            } else {
                print("Configuration file not detected.")
                createConfigPrompt()
            }
        }
    }
}
