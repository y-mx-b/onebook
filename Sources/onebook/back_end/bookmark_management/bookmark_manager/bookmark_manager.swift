import Foundation

struct BookmarkManager {
    // TODO remove hard-coded bookmarks directory
    var browserName: String?
    var bookmarksFilePath: String?
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"
}
