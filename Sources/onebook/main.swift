import Foundation
import BookmarkParser

let bookmark = OnebookChildren(name: "Bookmark", url: "URL", children: nil)
let folder = OnebookChildren(name: "Folder", url: nil, children: [bookmark])

let wrapper = OnebookChildrenWrapper(folder)
let jsonData = try! JSONEncoder().encode(wrapper)
let jsonString = String(data: jsonData, encoding: .utf8)!
print(jsonString)


// Onebook.main()
