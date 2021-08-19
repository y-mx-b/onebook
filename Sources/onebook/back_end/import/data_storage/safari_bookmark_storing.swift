import Foundation

func storeSafariBookmarks(_ bookmarksData: SafariBookmarks, storeAt bookmarksPath: URL) {
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
