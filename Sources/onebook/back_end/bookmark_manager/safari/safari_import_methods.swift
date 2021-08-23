import Foundation

extension BookmarkManager {
    public struct SafariBookmarkManager {
        public func getBookmarks(from bookmarksFilePath: URL) -> Data? {
            do {
                let contents = try Data(contentsOf: bookmarksFilePath)
                return contents
            } catch {
                print(error)
                return nil
            }
        }
        public func parseBookmarks(_ bookmarksDump: Data?) -> SafariBookmarks? {
            if bookmarksDump == nil {
                print("ERROR: COULD NOT RETRIEVE BOOKMARK DATA")
            }

            let plistData = bookmarksDump
            let decoder = PropertyListDecoder()
            let data = try! decoder.decode(SafariBookmarks.self, from: plistData!)
            return data
        }
        public func storeBookmarks(_ bookmarksData: SafariBookmarks, storeAt storageDirectory: String) {
            let fileManager = FileManager.default
            let bookmarksFolderPath = URL(fileURLWithPath: "\(NSHomeDirectory())/.bookmarks/", isDirectory: true)

            let bookmarks = bookmarksData.Children![4...]

            var foldersArray: [SafariChildren] = []
            var nestedFoldersArray: [SafariChildren] = []
            var bookmarksArray: [SafariChildren] = []

            for item in bookmarks {
                switch item.WebBookmarkType {
                case "WebBookmarkTypeList":
                    foldersArray.append(item)
                case "WebBookmarkTypeLeaf":
                    bookmarksArray.append(item)
                default:
                    print("failure")
                }
            }

            for bookmark in bookmarksArray {
                fileManager.createFile(atPath: "\(NSHomeDirectory())/.bookmarks/\(bookmark.URIDictionary!.title)", contents: nil, attributes: nil)
            }

            for item in foldersArray {
                let folderPath = bookmarksFolderPath.appendingPathComponent(item.Title!, isDirectory: true)
                do {
                    try fileManager.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)
                } catch {
                }
            }

            for item in foldersArray {
                for child in item.Children! {
                    switch child.WebBookmarkType {
                    case "WebBookmarkTypeList":
                        let folderPath = bookmarksFolderPath.appendingPathComponent("\(item.Title!)/\(child.Title!)", isDirectory: true)
                        nestedFoldersArray.append(child)
                        do {
                            try fileManager.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)
                        } catch {
                        }
                    case "WebBookmarkTypeLeaf":
                        let bookmarkPath = "\(NSHomeDirectory())/.bookmarks/\(item.Title!)/\(child.URIDictionary!.title)"
                            fileManager.createFile(atPath: bookmarkPath, contents: nil, attributes: nil)
                    default:
                        print("failure")
                    }
                }
            }
        }
    }
}