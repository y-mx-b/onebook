import Cocoa

let home = NSHomeDirectory()

let chromiumBookmarks = NSURL(fileURLWithPath: "\(home)/Library/Application Support/Chromium/Default/Bookmarks") as URL
