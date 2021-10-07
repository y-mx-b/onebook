import Foundation
import ArgumentParser
import BookmarkParser

extension Onebook {
    struct Clean: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Remove empty folders.")
        @OptionGroup var options: Onebook.Options

        mutating func run() {
            let bookmarkManager = BookmarkManager()
            bookmarkManager.clean()
        }
    }
}
