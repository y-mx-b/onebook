import Foundation

func testFileReadWrite() {
    let testFile = "file.txt"
    let testText = "Hello, World!"

    if let dir = FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first {

        let fileURL = dir.appendingPathComponent(testFile)

        do {
            try testText.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("Error")
        }

        do {
            let testText2 = try String(contentsOf: fileURL, encoding: .utf8)
            print(testText2)
        } catch {
            print("Error")
        }
    }
}
