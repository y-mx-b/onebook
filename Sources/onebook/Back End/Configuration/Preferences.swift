import Foundation
import BookmarkParser

enum CleanState: String {
    case emptyFolders
    case emptyBookmarks
}

struct Preferences: Codable {
    // NON-USER EDITABLE
    var configModifiedDate: TimeInterval = 0.0
    // PATHS
    var storageDirectory: String = "\(NSHomeDirectory())/.bookmarks/"
    var configPath: String = "\(NSHomeDirectory())/.config/onebook/onebookrc"
    // add browser bookmark paths variable ig?

    // SETTINGS
    var configState: Bool = true
    var editor: String = "vim"
    var importDefault: [String] = [Browser.chrome.rawValue]
    var cleanPreferences: [String : Bool] = [CleanState.emptyFolders.rawValue : false,
                                            CleanState.emptyBookmarks.rawValue : true]
    var syncDefault: [String] = [Browser.chrome.rawValue]
    var exportDefault: [String] = [FormatTypes.html.rawValue]
    var readingList: Bool = false
    var debug: Bool = false

    // Fun
    var progressBar: Bool = false
}
