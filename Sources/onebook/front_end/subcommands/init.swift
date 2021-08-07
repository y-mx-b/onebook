import Foundation
import ArgumentParser

func createBookmarksDirectory() {
    let dir = FileManager.default
    let bookmarksPath = "\(NSHomeDirectory())/.bookmarks."
    do {
    try dir.createDirectory(atPath: bookmarksPath, withIntermediateDirectories: false, attributes: nil)
    } catch {
        print("Error")
    }
}

extension Onebook {
    struct Init: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Initialize the program.")

        @OptionGroup var options: Onebook.Options

        mutating func run() {
            let dir = FileManager.default
            let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
            do {
                let path = try dir.contentsOfDirectory(atPath: bookmarksPath)
                print(path)
            } catch {
                print("Bookmarks directory not detected. Create bookmarks directory?")
                print("Y/N?: ", terminator: "")
                let permission = readLine()
            }
        }
    }
}
