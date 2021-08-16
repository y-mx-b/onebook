import Foundation

func parseSafariBookmarks(_ safariBookmarkData: Data?) -> SafariBookmarks {
    if safariBookmarkData == nil {
        print("ERROR: COULD NOT RETRIEVE BOOKMARK DATA")
    }

    let plistData = safariBookmarkData
    let decoder = PropertyListDecoder()
    let data = try! decoder.decode(SafariBookmarks.self, from: plistData!)
    return data
}

func getSafariBookmarks(from safariBookmarksPath: URL) -> Data? {
    do {
        let contents = try Data(contentsOf: safariBookmarksPath)
        return contents
    } catch {
        print(error)
        return nil
    }
}
