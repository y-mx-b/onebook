import Foundation

struct BookmarkManager {
    var browserName: String?
    var bookmarksFilePath: String?
    var storageDirectory = "\(NSHomeDirectory())/.bookmarks/"
}
