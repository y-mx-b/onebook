#if os(macOS)
import Foundation
import BookmarkParser

extension SafariBookmarkManager {
    public func storeBookmarks(_ bookmarksData: SafariChildren?, storeAt storageDirectory: String) {
        let fileManager = FileManager.default

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
                        var folderName: String

                        switch item.Title! {
                        case "com.apple.ReadingList":
                            folderName = "Reading List"
                        case "BookmarksBar":
                            folderName = "Bookmarks Bar"
                        default:
                            folderName = item.Title!
                        }

                        folderPath = folderPath + folderName + "/"

                        do { try createFolder(at: folderPath)  } catch { }
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
#endif