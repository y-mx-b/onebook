import Foundation
import BookmarkParser

enum CleanState: String {
    case emptyFolders
    case emptyBookmarks
}

enum PreferenceKeys: String {
    // PATHS
    case storageDirectory = "storage"
    case configPath = "config-path"

    // SETTINGS
    case configState = "config"
    case editor
    case importDefault = "import"
    case cleanPreferences = "clean"
    case syncDefault = "sync"
    case exportDefault = "export"
    case readingList = "reading-list"
    case debug

    // Fun
    case progressBar = "progress-bar"
}

struct Preferences: Codable {
    // NON-USER EDITABLE
    var preferencesPath: String = "\(NSHomeDirectory())/Library/Application Support/onebook/Preferences.plist"
    var configModifiedDateCalc: TimeInterval? {
        if InitManager().checkForConfigFile(configPath) {
            return try! URL(fileURLWithPath: configPath)
                            .resourceValues(forKeys: [URLResourceKey.contentModificationDateKey])
                            .contentModificationDate?.timeIntervalSince1970
        } else {
            return 0.0
        }
    }
    var configModifiedDate: TimeInterval? = 0.0

    // PATHS
    var storageDirectory: String = "\(NSHomeDirectory())/.bookmarks/"
    var configPath: String = "\(NSHomeDirectory())/.config/onebook/onebookrc"
    // add browser bookmark paths variable ig?

    // SETTINGS
    var configState: Bool = true
    var editor: String = ProcessInfo.processInfo.environment["EDITOR"]!
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
