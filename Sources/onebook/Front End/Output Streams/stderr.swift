import Foundation

struct StandardErrorOutputStream: TextOutputStream {
    let stderr = FileHandle.standardError

    func write(_ string: String) {
        guard let data = string.data(using: .utf8) else {
            return
        }
        stderr.write(data)
    }
}
