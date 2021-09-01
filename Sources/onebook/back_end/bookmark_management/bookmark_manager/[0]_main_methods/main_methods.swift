import Foundation

extension BookmarkManager {
    func create(_ bookmarkPath: String, siteURL: String) -> Bool {
        // TODO: make the method safer
        // - Don't overwrite existing files
            // - Check to make sure a folder of the same name doesn't exist
        // - Check to make sure the URL is valid
        //   - If it isn't, ask for confirmation

        let fileManager = FileManager.default

        let fullPath = (storageDirectory + bookmarkPath).replacingOccurrences(of: "//", with: "/")
        let directoryPath = fullPath.components(separatedBy: "/").dropLast(1).joined(separator: "/")
        let siteURLasURL = URL(string: siteURL)

        let bookmarkContents = Data("""
        url = \(String(describing: siteURLasURL!))
        date_added = \(String(Date().timeIntervalSince1970).replacingOccurrences(of: ".", with: ""))
        guid = \(UUID().uuidString)
        """.utf8)

        try! fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
        if fileManager.createFile(atPath: fullPath, contents: bookmarkContents) {
            return true
        } else { return false }
    }

    func remove(_ bookmarkPath: String) -> Bool {
        // TODO: add in checks, configurable confirmation
        let fileManager = FileManager.default

        let fullPath = (storageDirectory + bookmarkPath).replacingOccurrences(of: "//", with: "/")
        do {
            try fileManager.removeItem(atPath: fullPath)
            return true
        } catch {
            return false
        }
    }

    func edit(_ bookmarkPath: String) -> Bool {
        // TODO: allow for editing bookmarks with $EDITOR
        let fileManager = FileManager.default
        let fullPath = (storageDirectory + bookmarkPath).replacingOccurrences(of: "//", with: "/")
        return false
    }

    func move(_ originalPath: String?, to newPath: String?) {
        // TODO check if already existing, move files accordingly
    }

    func clean() {
        // TODO: remove empty bookmark folders
        let fileManager = FileManager.default
        let paths = try! fileManager.subpathsOfDirectory(atPath: storageDirectory)
        print(storageDirectory)
        print(paths)
    }

    func sync(_ browsers: [String]) {
        // TODO: sync bookmarks between browsers (this might take a while)
    }
}
