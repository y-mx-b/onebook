import Foundation

func parseChromiumBookmarks(_ chromiumBookmarkData: String?) -> ChromiumBookmarks {
    if chromiumBookmarkData == nil {
        print("ERROR: COULD NOT RETRIEVE BOOKMARK DATA")
    }

    let jsonData = chromiumBookmarkData!.data(using: .utf8)
    let decoder = JSONDecoder()
    let data = try! decoder.decode(ChromiumBookmarks.self, from: jsonData!)
    return data
}

func getChromiumBookmarks(from chromiumBookmarksPath: URL) -> String? {
    do {
        let contents = try String(contentsOf: chromiumBookmarksPath, encoding: .utf8)
        return contents
    } catch {
        print(error)
        return nil
    }
}
