#if os(macOS)
import Foundation

extension BookmarkManager {
    public struct SafariBookmarkManager: BrowserBookmarkManager {
        public func getBookmarks(from bookmarksFilePath: URL) -> Data? {
            // TODO change fuction to throw, make safer
            do {
                let contents = try Data(contentsOf: bookmarksFilePath)
                return contents
            } catch {
                print(error)
                return nil
            }
        }
        public func parseBookmarks(_ bookmarksDump: Data?) -> SafariChildren? {
            // TODO change function to throw, make safer
            if bookmarksDump == nil { return nil }
            let plistData = bookmarksDump
            let decoder = PropertyListDecoder()
            let data = try! decoder.decode(SafariChildren.self, from: plistData!)
            return data
        }

        // TODO: add dates in bookmark files
        // TODO: add recursive method to go create all folders and files
        public func storeBookmarks(_ bookmarksData: SafariChildren?, storeAt storageDirectory: String) {
            let fileManager = FileManager.default

            // let bookmarks = bookmarksData.Children![1...]

            // var foldersArray: [SafariChildren] = []
            // var nestedFoldersArray: [SafariChildren] = []
            // var bookmarksArray: [SafariChildren] = []

            func createFolder(at folderPath: String) throws {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: false)
            }

            func createFile(at filePath: String, bookmark: SafariChildren) {
                let bookmarkData = Data("""
                url = \(bookmark.URLString!)
                date_added = \(Date().timeIntervalSince1970)
                guid = \(bookmark.WebBookmarkUUID)
                """.utf8)
                fileManager.createFile(atPath: filePath, contents: bookmarkData)
            }

            func recursiveStorage(_ bookmarkArray: [SafariChildren], at basePath: String) {
                var folderPath: String

                for item in bookmarkArray {
                    folderPath = basePath + "/"
                    switch item.WebBookmarkType {
                    case "WebBookmarkTypeLeaf":
                        createFile(at: folderPath + item.URIDictionary!.title, bookmark: item)
                    case "WebBookmarkTypeList":
                        if item.Title != nil && item.Children != nil {
                        folderPath = folderPath + item.Title! + "/"
                        do { try createFolder(at: folderPath) } catch { }
                        recursiveStorage(item.Children!, at: folderPath)
                        }
                    default:
                        print()
                    }
                }
            }
            recursiveStorage(bookmarksData!.Children!, at: storageDirectory)
        }
    }
}
#endif
