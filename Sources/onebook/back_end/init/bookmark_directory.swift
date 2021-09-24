import Foundation

// TODO move functionality to back-end (allow functions to throw)
// TODO have print functions only on front-end

func checkForBookmarksDirectory() {
            let dir = FileManager.default
            let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
            var objCTrue: ObjCBool = true

            if dir.fileExists(atPath: bookmarksPath,
                              isDirectory: &objCTrue) {
                print("Bookmarks directory found: \(bookmarksPath)")
            } else {
                print("Bookmarks directory not detected.")
                print("Create bookmarks directory?")
                print("Y/N?:", terminator: " ")
                createBookmarksDirectoryPrompt()
            }

}

func createBookmarksDirectory() -> Bool {
    let dir = FileManager.default
    let bookmarksPath = "\(NSHomeDirectory())/.bookmarks"
    do {
    try dir.createDirectory(atPath: bookmarksPath, withIntermediateDirectories: false, attributes: nil)
    return true;
    } catch {
        print("ERROR: FAILED TO CREATE BOOKMARKS DIRECTORY")
        return false;
    }
}

