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
            if bookmarksDump == nil { return nil }

            let plistData = bookmarksDump
            let decoder = PropertyListDecoder()
            let data = try! decoder.decode(SafariBookmarks.self, from: plistData!)
            return data
        }

        // TODO: add dates in bookmark files
        // TODO: add recursive method to go create all folders and files
        public func storeBookmarks(_ bookmarksData: SafariBookmarks, storeAt storageDirectory: String) {
            let fileManager = FileManager.default
            let storageDirectoryURL = URL(fileURLWithPath: storageDirectory, isDirectory: true)

            let bookmarks = bookmarksData.Children![1...]

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
                    print()
                }
            }

            for bookmark in bookmarksArray {
                let content = Data("""
                url = \(bookmark.URLString!)
                date_added =
                guid = \(bookmark.WebBookmarkUUID)
                """.utf8)
                let filePath = "\(storageDirectory)/\(bookmark.URIDictionary!.title)"
                fileManager.createFile(atPath: filePath, contents: content, attributes: nil)
            }

            for item in foldersArray {
                let folderPath = storageDirectoryURL.appendingPathComponent(item.Title!, isDirectory: true)
                do {
                    try fileManager.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)
                } catch {
                }
            }

            for item in foldersArray {
                if item.Children != nil {
                    for child in item.Children! {
                        switch child.WebBookmarkType {
                        case "WebBookmarkTypeList":
                            let folderPath = storageDirectoryURL.appendingPathComponent("\(item.Title!)/\(child.Title!)", isDirectory: true)
                            nestedFoldersArray.append(child)
                            do {
                                try fileManager.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)
                            } catch {
                            }
                        case "WebBookmarkTypeLeaf":
                            let content = Data("""
                            url = \(child.URLString!)
                            date_added =
                            guid = \(child.WebBookmarkUUID)
                            """.utf8)
                            let bookmarkPath = "\(storageDirectory)/\(item.Title!)/\(child.URIDictionary!.title)"
                            fileManager.createFile(atPath: bookmarkPath, contents: content, attributes: nil)
                        default:
                            print("failure")
                        }
                    }
                }
            }
        }
    }
}
