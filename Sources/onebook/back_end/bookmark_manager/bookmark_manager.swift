import Foundation

struct BookmarkManager {
    var browserName: String? = nil
    var bookmarksFilePath: String? = nil
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"
}
