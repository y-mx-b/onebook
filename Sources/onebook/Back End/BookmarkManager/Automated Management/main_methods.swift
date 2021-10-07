import Foundation
import BookmarkParser

extension BookmarkManager {
    func create(_ bookmarkPath: String, siteURL: String) -> Bool {
        return false
    }

    func remove(_ bookmarkPath: String) -> Bool {
        return false
    }

    func edit(_ bookmarkPath: String) -> Bool {
        return false
    }

    func move(_ originalPath: String?, to newPath: String?) {
        // TODO check if already existing, move files accordingly
    }

    func clean() {
    }

    func sync(_ browsers: [String]) {
        // TODO: sync bookmarks between browsers (this might take a while)
    }
}
