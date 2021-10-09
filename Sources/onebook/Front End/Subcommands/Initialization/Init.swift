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
            var preferences: Preferences = Preferences()

            let im = InitManager()

            // TODO RUN CHECKS
            //     TODO PREFERENCES
            //         if exists -> load preferences
            //     TODO CONFIG
            //     TODO STORAGE
        }
    }
}
