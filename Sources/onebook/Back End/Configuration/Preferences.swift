import Foundation

enum CleanState {
    case emptyFolders
    case emptyBookmarks
}

struct Preferences: Codable {
    // PATHS
    var storageDirectory: String = "\(NSHomeDirectory())/.bookmarks/"
    var configPath: String = "\(NSHomeDirectory())/.config/onebook/onebookrc"
    // add browser bookmark paths variable ig?

    // SETTINGS
    var editor: String
    var importDefault: [Browser] = .chrome
    var cleanPreferences: [CleanState : Bool] = [.emptyFolders: false, .emptyBookmarks: true]
    var syncDefault: [Browser] = .chrome
    var exportDefault: [FormatType] = .html
    var readingList: Bool = false
    var debug: Bool = false

    // Fun
    var progressBar: Bool = false
}
