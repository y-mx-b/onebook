import Foundation

struct ChromiumBookmarks: Decodable {
    let checksum: String
    struct Roots: Decodable {
        struct Children: Decodable {
            let date_added: String
            let guid: String
            let id: String
            let name: String
            let type: String
            let url: String
        }
        struct Folder: Decodable {
            let children: [Children]
            let date_added: String
            let guid: String
            let id: String
            let name: String
            let type: String
        }
        struct NestedFolders: Decodable {
            let children: [Folder]
            let date_added: String
            let guid: String
            let id: String
            let name: String
            let type: String
        }
        let bookmark_bar: Folder
        let other: NestedFolders
        let synced: Folder
    }
    let roots: Roots
    let version: Int
}

func parseChromiumBookmarks(_ chromiumBookmarkData: String?) -> ChromiumBookmarks {
    if chromiumBookmarkData == nil {
        print("ERROR: COULD NOT RETRIEVE BOOKMARK DATA")
    }

    let jsonData = chromiumBookmarkData!.data(using: .utf8)
    let decoder = JSONDecoder()
    let data = try! decoder.decode(ChromiumBookmarks.self, from: jsonData!)
    return data
}

func getChromiumBookmarks() -> String? {
    let chromiumBookmarksPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/Library/Application Support/Chromium/Default/Bookmarks") as URL

    do {
        let contents = try String(contentsOf: chromiumBookmarksPath, encoding: .utf8)
        return contents
    } catch {
        print(error)
        return nil
    }
}
